return {
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            -- list of servers for mason to install
            ensure_installed = {
                "ts_ls",
                "html",
                "cssls",
                "tailwindcss",
                "svelte",
                "lua_ls",
                "graphql",
                "emmet_ls",
                "prismals",
                "pyright",
                "eslint",
                "gopls", -- Go LSP (golangcilint is a linter, use in nvim-lint)
                -- rust-analyzer: use the rustup toolchain binary instead (see lspconfig.lua).
                -- Mason's standalone build lags the compiler and breaks macro expansion.
            },
        },
        dependencies = {
            {
                "williamboman/mason.nvim",
                opts = {
                    ui = {
                        icons = {
                            package_installed = "✓",
                            package_pending = "➜",
                            package_uninstalled = "✗",
                        },
                    },
                },
            },
            "neovim/nvim-lspconfig",
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = {
            ensure_installed = {
                "prettier", -- prettier formatter
                "stylua", -- lua formatter
                "isort", -- python formatter
                "black", -- python formatter
                "pylint",
                "eslint_d",
                "golangci-lint", -- Go linter for nvim-lint
                "golines", -- Go formatter that wraps long lines (gofmt has no line limit)
            },
        },
        dependencies = {
            "williamboman/mason.nvim",
        },
    },
}
