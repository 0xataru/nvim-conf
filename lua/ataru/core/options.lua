local opt = vim.opt

opt.relativenumber = true
opt.number = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4

opt.colorcolumn = "140"
opt.expandtab = true
opt.autoindent = true

opt.wrap = false

opt.showmode = false

opt.ignorecase = true
opt.smartcase = true

opt.cursorline = true
-- CursorLine and ColorColumn colors are set in colorscheme.lua (after theme loads)

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
-- Padding between line number column and text: spaces at end of statuscolumn
opt.statuscolumn = "%s%C%l%r   "

opt.backspace = "indent,eol,start"

opt.clipboard:append("unnamedplus")

opt.splitright = true
opt.splitbelow = true
