return {
	"mrs4ndman/theme-selector.nvim",
	cmd = { "Themer" },
	dependencies = {
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		require("theme-selector.colorschemes").list = {
			"catppuccin",
			"nord",
		}
		require("theme-selector")
	end,
}
