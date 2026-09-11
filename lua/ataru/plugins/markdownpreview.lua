return {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop", "MarkdownPreviewToggle" },
    ft = { "markdown" },
    build = function()
        -- the plugin is lazy, so source it before calling into its vimscript installer.
        -- install_sync blocks until the pre-built server binary is downloaded; the async
        -- install() would be killed when the build task finishes.
        require("lazy").load({ plugins = { "markdown-preview.nvim" } })
        vim.fn["mkdp#util#install_sync"]()
    end,
    keys = {
        { "<leader>mv", "<cmd>MarkdownPreviewToggle<CR>", ft = "markdown", desc = "Markdown preview toggle" },
    },
    init = function()
        vim.g.mkdp_auto_close = 0
        vim.g.mkdp_theme = "dark"
    end,
}
