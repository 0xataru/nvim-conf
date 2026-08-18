return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                javascript = { "prettier" },
                typescript = { "prettier" },
                javascriptreact = { "prettier" },
                typescriptreact = { "prettier" },
                svelte = { "prettier" },
                css = { "prettier" },
                html = { "prettier" },
                json = { "prettier" },
                yaml = { "prettier" },
                markdown = { "prettier" },
                graphql = { "prettier" },
                liquid = { "prettier" },
                lua = { "stylua" },
                python = { "isort", "black" },
                -- golines wraps long lines and runs gofmt itself, so gofmt is not needed here.
                go = { "golines" },
                rust = { "rustfmt" },
            },
            formatters = {
                golines = {
                    prepend_args = {
                        -- Keep in sync with opt.colorcolumn in core/options.lua.
                        "--max-len=120",
                        "--shorten-comments",
                        -- Length is counted with tabs expanded to this width (Go indents with tabs).
                        "--tab-len=4",
                        -- Don't column-align keys inside struct tags (json/validate/example stay as written).
                        "--no-reformat-tags",
                    },
                },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 3000,
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}
