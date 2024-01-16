local cmd = require("util").cmd

return {
	"stevearc/oil.nvim",
	keys = {
		{ "<leader>-", cmd("Oil"), desc = "open oil" },
	},
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {},
	config = true,
}
