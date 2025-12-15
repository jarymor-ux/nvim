local o = vim.o
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.smarttab = true
opt.expandtab = true
opt.termguicolors = true
vim.cmd[[colorscheme kanagawa]]

o.laststatus = 3
opt.cursorline = true
o.wrap = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.swapfile = false
opt.backup = false
opt.writebackup = false

vim.cmd('set list')
vim.cmd('set listchars=')
vim.cmd('set listchars+=tab:--')
vim.cmd('set listchars+=extends:·')
vim.cmd('set listchars+=precedes:·')
vim.cmd('set listchars+=nbsp:·')
vim.cmd('set listchars+=trail:·')
