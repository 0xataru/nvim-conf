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
        -- Route echo-area messages (incl. search count on n/N) to nvim-notify
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
