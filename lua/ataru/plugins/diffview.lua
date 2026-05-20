return {
    "sindrets/diffview.nvim",
    cmd = {
        "DiffviewOpen",
        "DiffviewClose",
        "DiffviewToggleFiles",
        "DiffviewFocusFiles",
        "DiffviewRefresh",
        "DiffviewFileHistory",
    },
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    keys = {
        { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview open" },
        { "<leader>gD", "<cmd>DiffviewClose<CR>", desc = "Diffview close" },
        { "<leader>gf", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview file history" },
    },
    opts = {
        use_icons = true,
    },
}
