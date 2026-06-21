-- WARN: VSCode Dark+ theme for Neovim
--
-- return {
--     {
--         "Mofiqul/vscode.nvim",
--         lazy = false,
--         priority = 1000,
--         config = function()
--             vim.cmd.colorscheme("vscode")
--
--
--     -- Cursor line and 140-column ruler (same color, applied after theme)
--     local line_highlight = "#4a4a4a"
--     vim.api.nvim_set_hl(0, "CursorLine", { bg = line_highlight })
--     vim.api.nvim_set_hl(0, "ColorColumn", { bg = line_highlight })
--
--         end,
--     },
-- }

-- WARN: Midnight theme for Neovim
--
-- return {
--     {
--         "dasupradyumna/midnight.nvim",
--         lazy = false,
--         priority = 1000,
--         config = function()
--             vim.cmd.colorscheme("midnight")
--
--
--     -- Cursor line and 140-column ruler (same color, applied after theme)
--     local line_highlight = "#4a4a4a"
--     vim.api.nvim_set_hl(0, "CursorLine", { bg = line_highlight })
--     vim.api.nvim_set_hl(0, "ColorColumn", { bg = line_highlight })
--
--         end,
--     },
-- }

-- WARN: GitHub Dark theme for Neovim
--
-- return {
--     {
--         "projekt0n/github-nvim-theme",
--         lazy = false,
--         priority = 1000,
--         config = function()
--             vim.cmd.colorscheme("github_dark_tritanopia")
--
--             -- Cursor line and 140-column ruler (same color, applied after theme)
--             local line_highlight = "#4a4a4a"
--             vim.api.nvim_set_hl(0, "CursorLine", { bg = line_highlight })
--             vim.api.nvim_set_hl(0, "ColorColumn", { bg = line_highlight })
--
--         end,
--     },
-- }

-- WARN: Oxocarbon theme for Neovim\
--
-- return {
--     {
--         "nyoom-engineering/oxocarbon.nvim",
--         lazy = false,
--         priority = 1000,
--         config = function()
--             vim.opt.background = "dark"
--             vim.cmd.colorscheme("oxocarbon")
--
--             -- Cursor line and 140-column ruler (same color, applied after theme)
--             local line_highlight = "#4a4a4a"
--             vim.api.nvim_set_hl(0, "CursorLine", { bg = line_highlight })
--             vim.api.nvim_set_hl(0, "ColorColumn", { bg = line_highlight })
--
--         end,
--     },
-- }

-- WARN: Sonokai theme for Neovim
--
-- return {
--     "sainnhe/sonokai",
--     lazy = false,
--     priority = 1000,
--     config = function()
--         -- Optionally configure and load the colorscheme
--         -- directly inside the plugin declaration.
--         vim.g.sonokai_enable_italic = true
--         vim.cmd.colorscheme("sonokai")
--
--         -- Cursor line and 140-column ruler (same color, applied after theme)
--         local line_highlight = "#4a4a4a"
--         vim.api.nvim_set_hl(0, "CursorLine", { bg = line_highlight })
--         vim.api.nvim_set_hl(0, "ColorColumn", { bg = line_highlight })
--     end,
-- }

-- WARN: Tokyonight theme for Neovim
--
return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Optionally configure and load the colorscheme
        -- directly inside the plugin declaration.
        vim.g.tokyonight_style = "night"
        vim.cmd.colorscheme("tokyonight")

        -- Match the kitty terminal background (~/.config/kitty/kitty.conf)
        local kitty_bg = "#1d1f21"
        vim.api.nvim_set_hl(0, "Normal", { bg = kitty_bg })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = kitty_bg })
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = kitty_bg })
        vim.api.nvim_set_hl(0, "SignColumn", { bg = kitty_bg })
        vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = kitty_bg })

        -- Cursor line and 140-column ruler (same color, applied after theme)
        local line_highlight = "#4a4a4a"
        vim.api.nvim_set_hl(0, "CursorLine", { bg = line_highlight })
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = line_highlight })
    end,
}
