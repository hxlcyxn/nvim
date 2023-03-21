return {
	"echasnovski/mini.comment",
	dependencies = {
		"JoosepAlviste/nvim-ts-context-commentstring",
	},
	event = "VeryLazy",
	opts  = {
		hooks = {
			pre = function()
				require("ts_context_commentstring.internal").update_commentstring({})
			end,
		},
		mappings = {
			comment = "<leader>c",
			comment_line = "<leader>cc",
			textobject = "cc",
		}
	},
	config = require("util").wrapsetup("mini.comment"),
}
