-- https://github.com/akinsho/nvim-bufferline.lua/
require("bufferline").setup({
	options = {
		view = "default",
		numbers = "none",
		buffer_close_icon = "",
		show_close_icon = false,
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 32,
		diagnostics = "nvim_lsp",
		separator_style = "thin",
	},
})

vim.opt.showtabline = 2
