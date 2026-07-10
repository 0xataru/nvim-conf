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
                fg = "#008C00",
                bold = true,
                italic = false,
            },
            indicator_selected = {
                fg = "#008C00",
            },
            separator_selected = {
                fg = "#008C00",
            },
        },
    },
}
