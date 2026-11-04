return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        {
            "Crysthamus/nvim-file-operations",
            config = function()
                require("nvim-file-operations").setup()
            end,
        },
    },
    config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap

        local severity_names = { "Error", "Warn", "Info", "Hint" }

        local function float_severity(bufnr, scope)
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))
            local on_line = vim.diagnostic.get(bufnr, { lnum = row - 1 })
            local shown = vim.tbl_filter(function(d)
                return scope ~= "cursor" or (d.col <= col and col <= (d.end_col or d.col))
            end, on_line)
            if #shown == 0 then
                shown = on_line
            end
            local best = vim.diagnostic.severity.HINT
            for _, d in ipairs(shown) do
                best = math.min(best, d.severity)
            end
            return best
        end

        local function open_diagnostic_float(float_opts)
            float_opts = float_opts or {}
            local bufnr = float_opts.bufnr or vim.api.nvim_get_current_buf()
            local name = severity_names[float_severity(bufnr, float_opts.scope)]
            local _, win = vim.diagnostic.open_float(float_opts)
            if win then
                vim.wo[win].winhighlight = ("NormalFloat:DiagnosticFloat%sNormal,FloatBorder:DiagnosticFloat%sBorder"):format(
                    name,
                    name
                )
            end
        end

        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                -- Buffer local mappings.
                -- See `:help vim.lsp.*` for documentation on any of the below functions
                local opts = { buffer = ev.buf, silent = true }

                -- set keybinds
                opts.desc = "Show LSP references"
                keymap.set("n", "gR", "<cmd>Trouble lsp_references toggle<CR>", opts) -- show references in Trouble (close with q)

                opts.desc = "Go to declaration"
                keymap.set("n", "gD", function()
                    -- Many servers don't implement textDocument/declaration; fall back to definition.
                    local clients = vim.lsp.get_clients({ bufnr = ev.buf })
                    local supports_declaration = false
                    for _, client in ipairs(clients) do
                        if client:supports_method("textDocument/declaration") then
                            supports_declaration = true
                            break
                        end
                    end
                    if supports_declaration then
                        vim.lsp.buf.declaration()
                    else
                        vim.lsp.buf.definition()
                    end
                end, opts) -- go to declaration (falls back to definition)

                opts.desc = "Show LSP definition"
                keymap.set("n", "gd", vim.lsp.buf.definition, opts) -- show lsp definition

                opts.desc = "Show LSP implementations"
                keymap.set("n", "gi", "<cmd>Trouble lsp_implementations toggle<CR>", opts) -- show implementations in Trouble (close with q)

                opts.desc = "Show LSP type definitions"
                keymap.set("n", "gt", "<cmd>Trouble lsp_type_definitions toggle<CR>", opts) -- show type definitions in Trouble (close with q)

                opts.desc = "See available code actions"
                keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, 
                -- in visual mode will apply to selection

                opts.desc = "Smart rename"
                keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>cd", function()
                    open_diagnostic_float()
                end, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", function()
                    vim.diagnostic.jump({
                        count = -1,
                        on_jump = function(_, bufnr)
                            open_diagnostic_float({ bufnr = bufnr, scope = "cursor", focus = false })
                        end,
                    })
                end, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", function()
                    vim.diagnostic.jump({
                        count = 1,
                        on_jump = function(_, bufnr)
                            open_diagnostic_float({ bufnr = bufnr, scope = "cursor", focus = false })
                        end,
                    })
                end, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end,
        })

        local capabilities = vim.tbl_deep_extend(
            "force",
            cmp_nvim_lsp.default_capabilities(),
            require("nvim-file-operations.config").default_capabilities()
        )

        -- Apply capabilities to all LSP servers (Neovim 0.11+ / mason-lspconfig uses vim.lsp.config, no setup_handlers)
        vim.lsp.config("*", { capabilities = capabilities })

        -- Use the rustup-provided rust-analyzer (the ~/.cargo/bin proxy respects the
        -- project's active toolchain, incl. rust-toolchain.toml) instead of Mason's
        -- standalone binary. Mason's build lags the compiler, and a version-skewed
        -- rust-analyzer fails to expand macros -> bogus "unresolved macro" /
        -- "expected !, found ()" errors on code that builds fine. mason.nvim also
        -- prepends its bin/ to PATH, so we pin an explicit path here to avoid shadowing.
        local rustup_ra = vim.fn.expand("$HOME/.cargo/bin/rust-analyzer")
        if vim.fn.executable(rustup_ra) == 1 then
            vim.lsp.config("rust_analyzer", { cmd = { rustup_ra } })
        end

        local severity = vim.diagnostic.severity

        vim.diagnostic.config({
            float = { border = "rounded" },
            signs = {
                text = {
                    [severity.ERROR] = " ",
                    [severity.WARN] = " ",
                    [severity.HINT] = "󰠠 ",
                    [severity.INFO] = " ",
                },
            },
        })
    end,
}

