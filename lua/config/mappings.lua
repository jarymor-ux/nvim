local map = vim.keymap.set
local Snacks = require("snacks")

-- nvim controll
map("n", ";", ":", { desc = "CMD enter command mode" })
map({ "i", "v" }, "jj", "<ESC>")

-- show filepath
map("n", "pp", function()
	local path = vim.fn.expand("%:p")
	print(path)
end, { desc = "Show full file path" })

-- quickfix
map("n", "qq", function()
	require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

-- telescope
local teleb = require("telescope.builtin")
map("n", "<leader>ff", teleb.find_files, { desc = "Find files" })
map("n", "<leader>fw", teleb.live_grep, { desc = "Find file by word" })

-- lsp
map("n", "ff", vim.lsp.buf.format, { desc = "Format file" })
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Defenition" })
map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implemented interfaces" })
map("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })

-- split
map("n", "<leader>s", ":vsplit<Enter>", { desc = "Vertical split" })
--explorer
map("n", "<leader>e", function ()
Snacks.explorer()
end, { desc = "Open/Close Explorer" })
map("n", "<leader>cc", ":NvimTreeCollapse<Enter>", { desc = "Collapse all folders" })
-- diagnostics
map("n", "<leader>fd", ":Telescope diagnostics <CR>", { desc = "Telescope Diagnostic File" })
--term
map("n", "<leader>h", ":ToggleTerm direction=horizontal size=10<Enter>", {desc = "Open terminal"})
map("n", "<leader>v", ":ToggleTerm direction=vertical size=50<Enter>", {desc = "Open terminal"})
--git
map("n", "<leader>lg", ":LazyGit<Enter>", { desc = "Run LazyGit" })

map("n", "<leader>z", function ()
Snacks.zen()
end)
