-- Copilot ghost text renders on the cursor line, and line_highlight (#4a4a4a)
-- washes out most themes' defaults for it -- tokyonight's #444a73 sits at a
-- 1.1:1 contrast ratio against it. Re-applied on every colorscheme.
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ataru_copilot_hl", { clear = true }),
    callback = function()
        vim.api.nvim_set_hl(0, "CopilotSuggestion", { fg = "#9aa5cc", italic = true })
        vim.api.nvim_set_hl(0, "CopilotAnnotation", { fg = "#9aa5cc", italic = true })
    end,
})

-- Gitsigns inline blame (<leader>hB) in violet, readable on line_highlight.
vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("ataru_blame_hl", { clear = true }),
    callback = function()
        vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#bb9af7", italic = true })
    end,
})

return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        local function apply_overrides()
            -- Match the terminal background (example-ghostty.conf / example-kitty.conf)
            local terminal_bg = "#1d1f21"
            vim.api.nvim_set_hl(0, "Normal", { bg = terminal_bg })
            vim.api.nvim_set_hl(0, "NormalNC", { bg = terminal_bg })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = terminal_bg })
            vim.api.nvim_set_hl(0, "SignColumn", { bg = terminal_bg })
            vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = terminal_bg })

            -- Neo-tree uses its own highlight groups
            vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = terminal_bg })
            vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = terminal_bg })
            vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = terminal_bg })

            -- Cursor line and 120-column ruler (same color)
            local line_highlight = "#4a4a4a"
            vim.api.nvim_set_hl(0, "CursorLine", { bg = line_highlight })
            vim.api.nvim_set_hl(0, "ColorColumn", { bg = line_highlight })

            local diagnostic_float_colors = {
                Error = { bg = "#4a2c3b", border = "#f2a7c3" },
                Warn = { bg = "#4a3d24", border = "#e6c384" },
                Info = { bg = "#23394a", border = "#8cc8f0" },
                Hint = { bg = "#263f33", border = "#9ece9a" },
            }
            for name, c in pairs(diagnostic_float_colors) do
                vim.api.nvim_set_hl(0, "DiagnosticFloat" .. name .. "Normal", { bg = c.bg })
                vim.api.nvim_set_hl(0, "DiagnosticFloat" .. name .. "Border", { fg = c.border, bg = c.bg })
            end
        end

        vim.api.nvim_create_autocmd("ColorScheme", {
            group = vim.api.nvim_create_augroup("ColorschemeOverrides", { clear = true }),
            callback = apply_overrides,
        })

        vim.cmd.colorscheme("tokyonight-night")
    end,
}
