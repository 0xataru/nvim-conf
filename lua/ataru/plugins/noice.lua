return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    opts = {
        cmdline = {
            enabled = true,
            view = "cmdline_popup",
            opts = {},
        },
        messages = {
            enabled = true,
            view = "notify",
            opts = {},
        },
        -- Route all echo-area messages (including "Written", errors, LSP, etc.) to nvim-notify popups
        routes = {
            { filter = { event = "msg_show" }, view = "notify" },
        },
        views = {
            cmdline_popup = {
                position = {
                    row = "50%",
                    col = "50%",
                },
                size = {
                    width = 60,
                    height = "auto",
                },
                border = {
                    style = "rounded",
                    padding = { 0, 1 },
                },
            },
        },
    },
}
