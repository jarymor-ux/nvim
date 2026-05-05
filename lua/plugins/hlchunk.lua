return {
	"shellRaining/hlchunk.nvim",

	event = "BufReadPre",

	config = function()
		require("hlchunk").setup({

			chunk = {

				enable = true,

				use_treesitter = true,

				style = "#7aa2f7", -- цвет линии
			},
		})
	end,
}
