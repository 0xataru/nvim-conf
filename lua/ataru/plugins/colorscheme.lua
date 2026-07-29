-- Copilot ghost text renders on the cursor line, and line_highlight (#4a4a4a)
-- washes out most themes' defaults for it -- tokyonight's #444a73 sits at a
-- 1.1:1 contrast ratio against it. Re-applied on every colorscheme so the
-- themes below stay usable when swapped in.
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ataru_copilot_hl", { clear = true }),
    callback = function()
        vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#9aa5cc", italic = true })
        vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#9aa5cc", italic = true })
    end,
})

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

        -- Neo-tree uses its own highlight groups
        vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = kitty_bg })
        vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = kitty_bg })
        vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = kitty_bg })

        -- Cursor line and 140-column ruler (same color, applied after theme)
        local line_highlight = "#4a4a4a"
        vim.api.nvim_set_hl(0, "CursorLine", { bg = line_highlight })
        vim.api.nvim_set_hl(0, "ColorColumn", { bg = line_highlight })
    end,
}
