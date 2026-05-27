return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    version = "*",
    opts = {
        options = {
            mode = "buffers",
            separator_style = "slant",
        },
        highlights = {
            buffer_selected = {
                fg = "#FF8C00",
                bold = true,
                italic = false,
            },
            indicator_selected = {
                fg = "#FF8C00",
            },
            separator_selected = {
                fg = "#FF8C00",
            },
        },
    },
}
