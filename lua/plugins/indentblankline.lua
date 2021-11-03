-- https://github.com/lukas-reineke/indent-blankline.nvim/
require("indent_blankline").setup({
	char = "▏",
	show_end_of_line = true,
	filetype_exclude = {
		"help",
		"packer",
		"dashboard",
		"NvimTree",
		"man",
		"lspinfo",
		"TelescopePrompt",
	},
	show_current_context = true,
	context_patterns = {
		"class",
		"function",
		"method",
		"^if",
		"^while",
		"^for",
		"^object",
		"^table",
		"block",
		"arguments",
	},
})
