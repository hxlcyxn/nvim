local cmd = require("util").cmd

return {
	"stevearc/aerial.nvim",
	cmd = {
		"AerialToggle",
		"AerialOpen",
		"AerialNavToggle",
		"AerialNavClose",
	},
	keys = {
		{ "<leader>mo", cmd("Telescope aerial"), desc = "open symbols outline" },
	},
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		nav = {
			border = Settings.borderchars,
		},
	},
	config = function(_, opts)
		require("aerial").setup(opts)
		require("telescope").load_extension("aerial")
	end,
}
