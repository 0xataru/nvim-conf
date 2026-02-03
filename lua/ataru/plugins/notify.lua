return {
    "rcarriga/nvim-notify",
    priority = -100, -- load early so vim.notify override is active for all plugins
    config = function()
        local notify = require("notify")
        notify.setup({
            position = "top_right",
            stages = "fade_in_slide_out",
            timeout = 3000,
            background_colour = "Normal",
            max_width = 80,  -- wider so long paths/messages wrap instead of truncating
            max_height = 20, -- more lines for wrapped content
            level = vim.log.levels.INFO,
            render = "default",
            fps = 30,
        })
        vim.notify = notify
    end,
}
