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
			border = Settings.border,
		},
		preview = {
			border = Settings.border,
		},
		progress = {
			border = Settings.border,
		},
		ssh = {
			border = Settings.border,
		},
		keymaps_help = {
			border = Settings.border,
		},
	},
	config = true,
}
