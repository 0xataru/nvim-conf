return {
    "Mofiqul/vscode.nvim",
    priority = 1000,
    config = function()
        vim.cmd("colorscheme vscode")
    end,

    -- One Dark Pro: popular VSCode-like dark theme with full treesitter support
    -- "olimorris/onedarkpro.nvim",
    -- priority = 1000,
    -- config = function()
    --     require("onedarkpro").setup({
    --         options = {
    --             transparency = false,
    --         },
    --     })
    --     vim.cmd("colorscheme onedark")
    -- end,
}
