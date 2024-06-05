Utils = {}
Commands = {}

Settings = {
	colorscheme = "stargaze", -- "ayu"|"xresources"
	background = "light", -- "dark"|"light"
	guifont = "Intel One Mono",
	fontsize = "12",

	border = { " " },
	winblend = 10,
	pumblend = 10,

	ayu_mirage = false, -- true|false

	mapleader = " ", -- affects basically all commands, most important button
	localleader = ",", -- other commands
	indent_style = "tabs", -- tabs|spaces
	indent = 4, -- your indentation size

	lsp_autstart = false,

	lisp_filetypes = { "fennel", "lisp", "yuck" },
}

vim.loader.enable()

require("options")
require("pm")
require("mappings")

vim.schedule(function()
	vim.api.nvim_create_autocmd({ "VimLeave" }, {
		desc = "Set cursor to a blinking bar when leaving neovim.",
		callback = function()
			vim.opt.guicursor = "a:ver25-blinkon250"
			-- vim.opt.guicursor = "a:hor20-blinkon0"
		end,
	})
end)
