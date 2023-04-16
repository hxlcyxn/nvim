local cmd = require("util").cmd

return {
	"Wansmer/treesj",
	keys = {
		{ "<space>j", cmd("TSJJoin"), desc = "join node lines" },
		{ "<space>s", cmd("TSJSplit"), desc = "split node lines" },
	},
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		use_default_keymaps = false,
	},
	config = true,
}
