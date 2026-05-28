local function mason_pkg_path(name)
    local ok, registry = pcall(require, "mason-registry")
    if not ok then
        return nil
    end
    if not registry.has_package(name) or not registry.get_package(name):is_installed() then
        return nil
    end
    return registry.get_package(name):get_install_path()
end

local function substitute_vars(value)
    if type(value) ~= "string" then
        return value
    end
    local root = vim.fn.getcwd()
    return value
        :gsub("${workspaceFolder}", root)
        :gsub("${workspaceFolderBasename}", vim.fn.fnamemodify(root, ":t"))
        :gsub("${file}", vim.fn.expand("%:p"))
        :gsub("${fileDirname}", vim.fn.expand("%:p:h"))
end

local function parse_env_file(path)
    local env = {}
    local file = io.open(path, "r")
    if not file then
        vim.notify("DAP: env file not found: " .. path, vim.log.levels.ERROR)
        return env
    end

    for line in file:lines() do
        local trimmed = vim.trim(line)
        if trimmed ~= "" and not trimmed:match("^#") then
            local key, val = trimmed:match("^([^=]+)=(.*)$")
            if key then
                key = vim.trim(key)
                val = val:gsub('^"(.*)"$', "%1"):gsub("^'(.*)'$", "%1")
                env[key] = val
            end
        end
    end
    file:close()
    return env
end

local function find_go_mod_root(path)
    if not path or path == "" then
        return nil
    end
    path = vim.fs.normalize(path)
    if vim.fn.isdirectory(path) ~= 1 then
        path = vim.fs.dirname(path)
    end
    local mod = vim.fs.find("go.mod", { path = path, upward = true })[1]
    return mod and vim.fs.dirname(mod) or nil
end

local function normalize_go_program(program, mod_root)
    if not program or not mod_root then
        return program
    end

    program = vim.fs.normalize(program)
    mod_root = vim.fs.normalize(mod_root)

    if program == mod_root then
        return "."
    end

    local prefix = mod_root .. "/"
    if vim.startswith(program, prefix) then
        local rel = program:sub(#prefix + 1)
        if rel == "" then
            return "."
        end
        return "./" .. rel
    end

    return program
end

local function enrich_vscode_go_config(config)
    -- dap-go registers the "go" adapter (dlv dap); "delve" from mason ignores dlvCwd
    config.type = "go"
    config.mode = config.mode or "debug"
    config.request = config.request or "launch"

    if config.envFile then
        local env_path = substitute_vars(config.envFile)
        config.env = vim.tbl_extend("force", config.env or {}, parse_env_file(env_path))
        config.envFile = nil
    end

    if config.cwd then
        config.cwd = substitute_vars(config.cwd)
    end
    if config.program then
        config.program = substitute_vars(config.program)
    end

    local mod_root = find_go_mod_root(config.program or config.cwd)
        or (config.cwd and find_go_mod_root(config.cwd))
    if mod_root then
        config.dlvCwd = mod_root
        config.cwd = config.cwd or mod_root
        config.program = normalize_go_program(config.program, mod_root)
    end

    -- Send program stdout/stderr to dap-ui Console (not only to terminal)
    config.outputMode = "remote"

    -- VS Code-only fields that Delve/nvim-dap do not understand
    config.console = nil

    return config
end

local function resolve_config(config)
    if type(config) == "table" and getmetatable(config) and getmetatable(config).__call then
        return config()
    end
    return vim.deepcopy(config)
end

local function setup_vscode_launchjs()
    local dap = require("dap")
    local vscode = require("dap.ext.vscode")

    -- launch.json is loaded via providers in modern nvim-dap; enrich VS Code Go configs here
    dap.providers.configs["dap.launch.json"] = function()
        local configs = vscode.getconfigs()
        local result = {}

        for _, config in ipairs(configs) do
            local c = resolve_config(config)
            if c.type == "go" then
                c = enrich_vscode_go_config(c)
            end
            table.insert(result, c)
        end

        return result
    end
end

local function setup_js_dap()
    local install_path = mason_pkg_path("js-debug-adapter")
    if not install_path then
        return
    end

    local debugger_path = install_path .. "/js-debug/src/dapDebugServer.js"
    local dap = require("dap")

    for _, adapter in ipairs({ "pwa-node", "node" }) do
        dap.adapters[adapter] = {
            type = "server",
            host = "127.0.0.1",
            port = "${port}",
            executable = {
                command = "node",
                args = { debugger_path, "${port}", "127.0.0.1" },
            },
        }
    end

    local js_configs = {
        {
            type = "pwa-node",
            request = "launch",
            name = "Node: launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Node: launch with tsx",
            runtimeExecutable = "npx",
            runtimeArgs = { "tsx", "${file}" },
            cwd = "${workspaceFolder}",
            sourceMaps = true,
        },
        {
            type = "pwa-node",
            request = "launch",
            name = "Node: npm run dev",
            runtimeExecutable = "npm",
            runtimeArgs = { "run", "dev" },
            cwd = "${workspaceFolder}",
            sourceMaps = true,
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Node: attach to process",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
            sourceMaps = true,
        },
    }

    for _, ft in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
        dap.configurations[ft] = vim.list_extend(dap.configurations[ft] or {}, js_configs)
    end
end

local function read_cargo_toml(path)
    local file = io.open(path, "r")
    if not file then
        return nil
    end
    local content = file:read("*a")
    file:close()
    return content
end

local function parse_cargo_toml_field(content, field)
    for line in content:gmatch("[^\r\n]+") do
        local value = line:match("^" .. field .. "%s*=%s*\"([^\"]+)\"")
        if value then
            return value
        end
    end
    return nil
end

local function find_crate_root(path)
    if not path or path == "" then
        return nil
    end
    path = vim.fs.normalize(path)
    if vim.fn.isdirectory(path) ~= 1 then
        path = vim.fs.dirname(path)
    end
    local manifest = vim.fs.find("Cargo.toml", { path = path, upward = true })[1]
    if not manifest then
        return nil
    end
    local content = read_cargo_toml(manifest)
    if not content or not content:match("%[package%]") then
        return nil
    end
    return vim.fs.dirname(manifest), manifest, content
end

local function find_cargo_workspace_root(crate_root)
    local manifests = vim.fs.find("Cargo.toml", { path = crate_root, upward = true })
    for _, manifest in ipairs(manifests) do
        local content = read_cargo_toml(manifest)
        if content and content:match("%[workspace%]") then
            return vim.fs.dirname(manifest)
        end
    end
    return crate_root
end

local function get_rust_bin_name(cargo_content, package_name)
    local in_bin_section = false
    for line in cargo_content:gmatch("[^\r\n]+") do
        if line:match("^%[%[bin%]%]") then
            in_bin_section = true
        elseif line:match("^%[") then
            in_bin_section = false
        elseif in_bin_section then
            local name = line:match('^name%s*=%s*"([^"]+)"')
            if name then
                return name
            end
        end
    end
    return package_name
end

local function find_built_binary(workspace_root, bin_name, package_name)
    local names = { bin_name, "main", package_name }
    local seen = {}
    for _, name in ipairs(names) do
        if name ~= "" and not seen[name] then
            seen[name] = true
            local path = vim.fs.normalize(workspace_root .. "/target/debug/" .. name)
            if vim.fn.filereadable(path) == 1 then
                return path
            end
        end
    end

    local deps = vim.fn.glob(workspace_root .. "/target/debug/deps/" .. bin_name .. "-*", false, true)
    if type(deps) == "table" and deps[1] and vim.fn.filereadable(deps[1]) == 1 then
        return vim.fs.normalize(deps[1])
    end
    if type(deps) == "string" and deps ~= "" and vim.fn.filereadable(deps) == 1 then
        return vim.fs.normalize(deps)
    end

    return nil
end

local function parse_cargo_build_output(stdout, bin_name)
    local executable
    for line in stdout:gmatch("[^\r\n]+") do
        local ok, msg = pcall(vim.json.decode, line)
        if ok and msg.reason == "compiler-artifact" and msg.executable and msg.executable ~= "" then
            if not bin_name or (msg.target and msg.target.name == bin_name) then
                executable = vim.fs.normalize(msg.executable)
            end
        end
    end
    return executable
end

local function resolve_rust_debug_target(file_path)
    local crate_root, manifest, cargo_content = find_crate_root(file_path)
    if not crate_root then
        return nil, "No Cargo.toml with [package] near current file"
    end

    local package_name = parse_cargo_toml_field(cargo_content, "name")
    if not package_name then
        return nil, "Could not read package name from " .. manifest
    end

    local workspace_root = find_cargo_workspace_root(crate_root)
    local bin_name = get_rust_bin_name(cargo_content, package_name)
    local program = vim.fs.normalize(workspace_root .. "/target/debug/" .. bin_name)

    return {
        crate_root = crate_root,
        workspace_root = workspace_root,
        manifest = manifest,
        package_name = package_name,
        bin_name = bin_name,
        program = program,
    }, nil
end

local function build_rust_crate(target)
    local cmd = { "cargo", "build", "-p", target.package_name, "--message-format=json" }
    local env = vim.fn.environ()
    env.CARGO_TARGET_DIR = target.workspace_root .. "/target"

    local result
    if vim.system then
        result = vim.system(cmd, {
            cwd = target.workspace_root,
            env = env,
            stdout = true,
            stderr = true,
            text = true,
        }):wait()
    else
        local shell_cmd = string.format(
            "cd %s && CARGO_TARGET_DIR=%s cargo build -p %s --message-format=json 2>&1",
            vim.fn.shellescape(target.workspace_root),
            vim.fn.shellescape(env.CARGO_TARGET_DIR),
            target.package_name
        )
        local out = vim.fn.system(shell_cmd)
        result = { code = vim.v.shell_error, stdout = out, stderr = "" }
    end

    if result.code ~= 0 then
        local err = (result.stderr or "") .. (result.stdout or "")
        return false, "cargo build failed:\n" .. err
    end

    local program = parse_cargo_build_output(result.stdout or "", target.bin_name)
        or find_built_binary(target.workspace_root, target.bin_name, target.package_name)

    if not program or vim.fn.filereadable(program) ~= 1 then
        return false,
            "Binary not found after build (package: "
                .. target.package_name
                .. ", bin: "
                .. target.bin_name
                .. ")"
    end

    target.program = program
    return true, nil
end

local function prepare_rust_launch()
    local target, err = resolve_rust_debug_target(vim.fn.expand("%:p"))
    if not target then
        return nil, err
    end

    local ok, build_err = build_rust_crate(target)
    if not ok then
        return nil, build_err
    end

    return target, nil
end

local function setup_rust_dap()
    local dap = require("dap")

    dap.configurations.rust = vim.list_extend(dap.configurations.rust or {}, {
        {
            type = "codelldb",
            request = "launch",
            name = "Rust: debug crate (current file)",
            program = function()
                local target, err = prepare_rust_launch()
                if not target then
                    vim.notify(err, vim.log.levels.ERROR, { title = "DAP" })
                    return nil
                end
                return target.program
            end,
            cwd = function()
                local target = select(1, resolve_rust_debug_target(vim.fn.expand("%:p")))
                return target and target.crate_root or vim.fn.getcwd()
            end,
            stopOnEntry = false,
        },
    })
end

local function resize_dapui_sidebar(delta)
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        if vim.bo[buf].filetype:match("^dap") then
            vim.api.nvim_win_set_width(win, vim.api.nvim_win_get_width(win) + delta)
            return
        end
    end
end

local function setup_dap_keymaps()
    local dap = require("dap")
    local dapui = require("dapui")
    local keymap = vim.keymap

    keymap.set("n", "<leader>db", function()
        dap.toggle_breakpoint()
    end, { desc = "Debug: Toggle breakpoint" })

    keymap.set("n", "<leader>dB", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Conditional breakpoint" })

    keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
    keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step into" })
    keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step over" })
    keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step out" })
    keymap.set("n", "<leader>dt", dap.terminate, { desc = "Debug: Terminate" })
    keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
    keymap.set("n", "<leader>dr", function()
        dapui.float_element("repl", { width = 0.5, height = 0.5 })
    end, { desc = "Debug: REPL" })
    keymap.set("n", "<leader>dC", function()
        dapui.float_element("repl", { width = 0.92, height = 0.55, enter = true })
    end, { desc = "Debug: Logs (REPL, floating)" })
    keymap.set("n", "<leader>dl", dap.run_last, { desc = "Debug: Run last" })
    keymap.set("n", "<leader>dR", function()
        if vim.bo.filetype == "rust" then
            local target, err = prepare_rust_launch()
            if not target then
                vim.notify(err, vim.log.levels.ERROR, { title = "DAP" })
                return
            end
            dap.run({
                type = "codelldb",
                request = "launch",
                name = "Rust: " .. target.package_name,
                program = target.program,
                cwd = target.crate_root,
                stopOnEntry = false,
            })
            return
        end
        dap.continue({ new = true })
    end, { desc = "Debug: Pick config and run" })

    keymap.set("n", "<leader>d[", function() resize_dapui_sidebar(-5) end, { desc = "Debug: Decrease sidebar width" })
    keymap.set("n", "<leader>d]", function() resize_dapui_sidebar(5) end, { desc = "Debug: Increase sidebar width" })

    keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Continue" })
    keymap.set("n", "<F10>", dap.step_over, { desc = "Debug: Step over" })
    keymap.set("n", "<F11>", dap.step_into, { desc = "Debug: Step into" })
    keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step out" })
end

return {
    {
        "mfussenegger/nvim-dap",
        lazy = false,
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "leoluz/nvim-dap-go",
            {
                "jay-babu/mason-nvim-dap.nvim",
                dependencies = {
                    "williamboman/mason.nvim",
                },
            },
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
            vim.fn.sign_define(
                "DapBreakpointCondition",
                { text = "◆", texthl = "DiagnosticWarn", linehl = "", numhl = "" }
            )
            vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo", linehl = "DapStoppedLine", numhl = "" })

            require("nvim-dap-virtual-text").setup({
                commented = true,
            })

            local console_height = math.max(20, math.floor(vim.o.lines * 0.38))

            dapui.setup({
                icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
                floating = { border = "rounded" },
                layouts = {
                    {
                        elements = {
                            { id = "scopes", size = 0.5 },
                            { id = "stacks", size = 0.5 },
                        },
                        size = 32,
                        position = "left",
                    },
                    {
                        -- Delve stdout/stderr goes to dap-repl, not "console"
                        elements = {
                            { id = "repl", size = 1.0 },
                        },
                        size = console_height,
                        position = "bottom",
                    },
                },
            })

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open({})
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close({})
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close({})
            end

            require("mason-nvim-dap").setup({
                ensure_installed = { "delve", "codelldb", "js" },
                handlers = {},
            })

            local delve_path = mason_pkg_path("delve")
            if delve_path then
                require("dap-go").setup({
                    delve = {
                        path = delve_path .. "/dlv",
                        output_mode = "remote",
                    },
                })
            else
                require("dap-go").setup()
            end

            setup_vscode_launchjs()
            setup_js_dap()
            setup_rust_dap()
            setup_dap_keymaps()

            dap.listeners.before.event_terminated["dap_error_notify"] = function(_, body)
                if body and body.reason == "failed" then
                    vim.notify(
                        "DAP: " .. (body.message or "launch failed"),
                        vim.log.levels.ERROR,
                        { title = "DAP" }
                    )
                end
            end
        end,
    },
}
