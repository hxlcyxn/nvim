local cmd = require("util").cmd
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		preview_config = {
			border = Settings.border,
		},
		on_attach = function(bufnr)
			vim.api.nvim_buf_set_keymap(
				bufnr,
				"n",
				"<leader>gb",
				cmd("Gitsigns toggle_current_line_blame"),
				{ desc = "toggle line blame" }
			)
		end,
	},
	config = true,
}
