return {
	{
		"mrs4ndman/theme-selector.nvim",
		cmd = { "Themer" },
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("theme-selector.colorschemes").list = {
				"kanagawa",
				"nord",
			}
			require("theme-selector")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
        opts = {
            compile = true,
        }
	},
	{
		"shaunsingh/nord.nvim",
	},
}
