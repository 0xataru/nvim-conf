return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap

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
                        if client.supports_method("textDocument/declaration") then
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

                opts.desc = "Show buffer diagnostics"
                keymap.set("n", "<leader>D", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", opts) -- buffer diagnostics in Trouble (close with q)

                opts.desc = "Show line diagnostics"
                keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

                opts.desc = "Go to previous diagnostic"
                keymap.set("n", "[d", function()
                    vim.diagnostic.jump({ count = -1, float = true })
                end, opts) -- jump to previous diagnostic in buffer

                opts.desc = "Go to next diagnostic"
                keymap.set("n", "]d", function()
                    vim.diagnostic.jump({ count = 1, float = true })
                end, opts) -- jump to next diagnostic in buffer

                opts.desc = "Show documentation for what is under cursor"
                keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

                opts.desc = "Restart LSP"
                keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
            end,
        })

        local capabilities = cmp_nvim_lsp.default_capabilities()

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

