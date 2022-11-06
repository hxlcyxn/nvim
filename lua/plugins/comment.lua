local wk = require("which-key")
local api = require("Comment.api")

require("Comment").setup({
	mappings = false,
	pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
})

wk.register({
	prefix = "<leader>",
	mode = "n",
	c = {
		["<space>"] = {
			function()
				return vim.v.count == 0 and api.toggle.linewise.current() or api.toggle.linewise.count(vim.v.count)
			end,
			"comment line",
		},
		c = { "<Plug>(comment_toggle_linewise)", "comment motion" },
	},
})

wk.register({
	prefix = "<leader>",
	mode = "v",
	c = {
		["<space>"] = { "<Plug>(comment_toggle_linewise)", "comment lines" },
	},
})
