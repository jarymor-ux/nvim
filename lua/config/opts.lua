local o = vim.o
local opt = vim.opt

-- GUI/daemon запуски часто не наследуют shell PATH (Homebrew bin не виден).
-- Добавляем стандартные пути, чтобы внешние тулзы (например tree-sitter) находились стабильно.
local function ensure_path(dir)
    if vim.env.PATH and not vim.env.PATH:match(vim.pesc(dir)) then
        vim.env.PATH = dir .. ":" .. vim.env.PATH
    end
end

ensure_path("/opt/homebrew/bin")
ensure_path("/usr/local/bin")

opt.number = true
opt.relativenumber = true
opt.smarttab = true
opt.expandtab = true
opt.termguicolors = true

o.laststatus = 3
opt.cursorline = true
o.wrap = false
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

opt.swapfile = false
opt.backup = false
opt.writebackup = false

opt.list = true
opt.listchars = {
    tab = "--",
    extends = "·",
    precedes = "·",
    nbsp = "·",
    trail = "·",
}

vim.cmd.colorscheme("kanagawa-dragon")
