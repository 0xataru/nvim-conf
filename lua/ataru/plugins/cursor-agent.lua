return {
    "xTacobaco/cursor-agent.nvim",
    cmd = { "CursorAgent", "CursorAgentSelection", "CursorAgentBuffer", "CursorAgentContext", "CursorAgentHistory" },
    keys = {
        { "<leader>ag", "<cmd>CursorAgent<CR>", desc = "Cursor Agent: Toggle terminal (reopen if still running)" },
        { "<leader>ag", "<cmd>CursorAgentSelection<CR>", desc = "Cursor Agent: Send selection (run now)", mode = "v" },
        { "<leader>aG", "<cmd>CursorAgentBuffer<CR>", desc = "Cursor Agent: Send buffer" },
        { "<leader>ah", "<cmd>CursorAgentHistory<CR>", desc = "Cursor Agent: Open session history" },
    },
    config = function()
        require("cursor-agent").setup({
            cmd = "cursor-agent",
            args = {},
        })

        -- Open session history (cursor-agent ls) in a floating terminal
        local function open_agent_history()
            local cfg = require("cursor-agent.config").get()
            local util = require("cursor-agent.util")
            local termui = require("cursor-agent.ui.term")
            local base = util.to_argv(cfg.cmd)
            if not base or #base == 0 then
                vim.notify("cursor-agent: invalid cmd in config", vim.log.levels.ERROR)
                return
            end
            local argv = util.concat_argv(util.concat_argv(base, cfg.args or {}), { "ls" })
            local root = util.get_project_root()
            termui.open_float_term({
                argv = argv,
                title = "Cursor Agent: Session history",
                border = "rounded",
                width = 0.6,
                height = 0.6,
                cwd = root,
            })
        end
        vim.api.nvim_create_user_command("CursorAgentHistory", open_agent_history, {
            desc = "Open Cursor Agent session history (pick session to resume)",
        })

        -- Exit terminal mode with jk (same as insert mode); then press q to close the agent window
        vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    end,
}
