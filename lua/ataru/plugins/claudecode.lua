return {
    "coder/claudecode.nvim",
    dependencies = {
        "folke/snacks.nvim",
    },
    config = true,
    keys = {
        { "<leader>a", nil, desc = "AI" },
        { "<leader>ac", "<cmd>ClaudeCode<CR>", desc = "Claude Code: Toggle" },
        { "<leader>af", "<cmd>ClaudeCodeFocus<CR>", desc = "Claude Code: Focus" },
        { "<leader>ar", "<cmd>ClaudeCode --resume<CR>", desc = "Claude Code: Resume" },
        { "<leader>aC", "<cmd>ClaudeCode --continue<CR>", desc = "Claude Code: Continue" },
        { "<leader>am", "<cmd>ClaudeCodeSelectModel<CR>", desc = "Claude Code: Select model" },
        { "<leader>ab", "<cmd>ClaudeCodeAdd %<CR>", desc = "Claude Code: Add buffer" },
        { "<leader>as", "<cmd>ClaudeCodeSend<CR>", mode = "v", desc = "Claude Code: Send selection" },
        {
            "<leader>as",
            "<cmd>ClaudeCodeTreeAdd<CR>",
            desc = "Claude Code: Add file",
            ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
        },
        { "<leader>aa", "<cmd>ClaudeCodeDiffAccept<CR>", desc = "Claude Code: Accept diff" },
        { "<leader>ad", "<cmd>ClaudeCodeDiffDeny<CR>", desc = "Claude Code: Deny diff" },
        { "<leader>a[", "<cmd>vertical resize -5<CR>", desc = "Claude Code: Decrease width" },
        { "<leader>a]", "<cmd>vertical resize +5<CR>", desc = "Claude Code: Increase width" },
        { "<leader>a{", "<cmd>resize -5<CR>", desc = "Claude Code: Decrease height" },
        { "<leader>a}", "<cmd>resize +5<CR>", desc = "Claude Code: Increase height" },
    },
}
