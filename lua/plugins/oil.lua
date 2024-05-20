local cmd = require("util").cmd

return {
	"stevearc/oil.nvim",
	keys = {
		{ "<leader>-", cmd("Oil"), desc = "open oil" },
		{
			"<leader>fo",
			function()
				require("oil").toggle_float()
			end,
			desc = "open floating oil",
		},
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		columns = {
			"icon",
		},
		winoptions = {
			signcolumn = "yes",
		},
		float = {
			padding = 8,
			border = Settings.borderchars,
		},
		preview = {
			border = Settings.borderchars,
		},
		progress = {
			border = Settings.borderchars,
		},
		ssh = {
			border = Settings.borderchars,
		},
		keymaps_help = {
			border = Settings.borderchars,
		},
	},
	config = true,
}
