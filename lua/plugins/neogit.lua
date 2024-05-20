local cmd = require("util").cmd

return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gg", cmd("Neogit"), desc = "open neogit" },
	},
	opts = {
		graph_style = "unicode",
		console_timeout = 5 * 1000,
		integrations = {
			telescope = true,
			diffview = true,
		},
	},
	config = true,
}
