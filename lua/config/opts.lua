local o = vim.o
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.smarttab = true
opt.expandtab = true
opt.termguicolors = true
vim.cmd[[colorscheme kanagawa]]

o.laststatus = 0

o.wrap = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.swapfile = false
opt.backup = false
opt.writebackup = false

