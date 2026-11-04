return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        local golangcilint = lint.linters.golangcilint
        if golangcilint.args then
            golangcilint.args[#golangcilint.args] = function()
                local file = vim.api.nvim_buf_get_name(0)
                return vim.fs.root(file, "go.mod") and vim.fs.dirname(file) or file
            end
        end

        local function lint_buffer()
            lint.try_lint(nil, { cwd = vim.bo.filetype == "go" and vim.fs.root(0, "go.mod") or nil })
        end

        local go_events = { BufReadPost = true, BufWritePost = true }

        lint.linters_by_ft = {
            python = { "pylint" },
            go = { "golangcilint" },
        }

        vim.api.nvim_create_autocmd({ "BufReadPost", "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = vim.api.nvim_create_augroup("lint", { clear = true }),
            callback = function(ev)
                if vim.bo[ev.buf].filetype == "go" and not go_events[ev.event] then
                    return
                end
                lint_buffer()
            end,
        })

        vim.keymap.set("n", "<leader>l", lint_buffer, { desc = "Trigger linting for current file" })
    end,
}
