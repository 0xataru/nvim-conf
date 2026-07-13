return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- runs on every plugin install/update -> keeps installed parsers in sync
    -- with the queries bundled by the plugin (this is what `:TSUpdate` does)
    build = ":TSUpdate",
    lazy = false,
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        local TS = require("nvim-treesitter")

        -- On the `main` branch setup() only honors `install_dir`; every other
        -- master-era option (highlight/indent/folds/ensure_installed/...) is a no-op.
        TS.setup({})

        local ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
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
        }

        -- Install any parser we don't have yet (no-op for already-installed ones).
        local installed = TS.get_installed("parsers")
        local missing = vim.tbl_filter(function(lang)
            return not vim.tbl_contains(installed, lang)
        end, ensure_installed)
        if #missing > 0 then
            TS.install(missing)
        end

        -- Enable highlighting / folding / indentation per buffer.
        -- On `main` this is Neovim's job, triggered via vim.treesitter.start().
        local grp = vim.api.nvim_create_augroup("treesitter_start", { clear = true })
        vim.api.nvim_create_autocmd("FileType", {
            group = grp,
            callback = function(ev)
                local ft = vim.bo[ev.buf].filetype
                if ft == "" then
                    return
                end
                local lang = vim.treesitter.language.get_lang(ft) or ft
                if not vim.tbl_contains(TS.get_available(), lang) then
                    return
                end

                local function start()
                    if not vim.api.nvim_buf_is_valid(ev.buf) then
                        return
                    end
                    pcall(vim.treesitter.start, ev.buf)
                    -- treesitter-based folding (folds are provided by Neovim)
                    vim.wo.foldmethod = "expr"
                    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    -- treesitter-based indentation (still experimental upstream)
                    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end

                if vim.tbl_contains(TS.get_installed("parsers"), lang) then
                    start()
                else
                    -- Parser not present yet: install async, then start highlighting.
                    TS.install({ lang }):await(function()
                        vim.schedule(start)
                    end)
                end
            end,
        })
    end,
}
