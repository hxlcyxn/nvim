local cmd = require("util").cmd
return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol",
			delay = 10,
		},
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
