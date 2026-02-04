local ag = vim.api.nvim_create_augroup

local function set_yank_highlight()
    vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#e67e22" })
end

-- Apply once on load (in case autocmd runs after colorscheme)
set_yank_highlight()

-- Re-apply after colorscheme loads so it is not overwritten
vim.api.nvim_create_autocmd("ColorScheme", {
    pattern = "*",
    callback = set_yank_highlight,
    group = ag("YankHighlightRefresh", { clear = true }),
})

local yank_augroup = ag("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 170 })
    end,
    group = yank_augroup,
})
