local cmd = require("util").cmd

return {
	"TimUntersberger/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	cmd = "Neogit",
	keys = {
		{ "<leader>gg", cmd("Neogit"), desc = "open neogit" },
	},
	opts = {
		integrations = {
			diffview = true,
			console_timeout = 5 * 1000,
		},
	},
	config = true,
}
