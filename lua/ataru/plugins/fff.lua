return {
    "dmtrKovalenko/fff.nvim",
    lazy = false,
    build = function()
        require("fff.download").download_or_build_binary()
    end,
    opts = {
        layout = {
            height = 0.8,
            width = 0.8,
            prompt_position = "bottom",
            preview_position = "right",
            preview_size = 0.5,
            path_shorten_strategy = "middle_number",
        },
    },
    keys = {
        -- Keymaps are the same with telescope (<leader>f*)
        {
            "<leader>ff",
            function()
                require("fff").find_files()
            end,
            desc = "Fuzzy find files in cwd",
        },
        {
            "<leader>fr",
            -- fff uses frecency — frecency is a combination of frequency and recency,
            -- so it prioritizes files that are both frequently accessed and recently accessed.
            function()
                require("fff").find_files({ sort = "frecency" })
            end,
            desc = "Fuzzy find recent files (frecency)",
        },
        {
            "<leader>fs",
            function()
                require("fff").live_grep()
            end,
            desc = "Find str in cwd",
        },
        {
            "<leader>fc",
            function()
                require("fff").live_grep({ query = vim.fn.expand("<cword>") })
            end,
            desc = "Find str under cursor in cwd",
        },
        {
            "<leader>fz",
            function()
                require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
            end,
            desc = "Fuzzy grep in cwd",
        },
    },
}
