local cmd = require("util").cmd

return {
	"danymat/neogen",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"L3MON4D3/LuaSnip",
	},
	cmd = { "Neogen" },
	keys = { { "<leader>ma", cmd("Neogen"), "annotate scope" } },
	opts = {
		snippet_engine =  "luasnip",
		inpu_after_comment = true,
	},
	config = true,
}
