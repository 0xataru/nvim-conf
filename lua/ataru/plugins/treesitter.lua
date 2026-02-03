return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        folds = { enable = true },

        sync_install = true,
        auto_install = true,
        ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "go",
            "gomod",
            "gowork",
            "gosum",
            "rust",
            "css",
            "prisma",
            "dockerfile",
            "gitignore",
        },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
    },
    config = function(_, opts)
        local TS = require("nvim-treesitter")

        if type(opts.ensure_installed) ~= "table" then
            vim.notify("nvim-treesitter: ensure_installed must be a table", vim.log.levels.ERROR)
            return
        end

        TS.setup(opts)

        -- Explicitly start treesitter for each buffer (ensures highlighting works for Go and others)
        local ts_grp = vim.api.nvim_create_augroup("treesitter_highlight", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            group = ts_grp,
            callback = function(ev)
                if vim.bo[ev.buf].filetype == "go" then
                    pcall(vim.cmd, "TSInstall! go")
                end
                pcall(vim.treesitter.start, ev.buf)
            end,
        })
        vim.schedule(function()
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buflisted and vim.bo[buf].filetype ~= "" then
                    if vim.bo[buf].filetype == "go" then
                        pcall(vim.cmd, "TSInstall! go")
                    end
                    pcall(vim.treesitter.start, buf)
                end
            end
        end)
    end,
}
