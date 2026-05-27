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
        -- Route echo-area messages to nvim-notify, but skip search count on n/N
        routes = {
            {
                filter = { event = "msg_show", kind = "search_count" },
                opts = { skip = true },
            },
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
