Utils = {}
Commands = {}

Settings = {
	colorscheme = "ayu", -- "ayu"|"xresources"
	background = "dark", -- "dark"|"light"

	ayu_mirage = false, -- true|false

	mapleader = " ", -- affects basically all commands, most important button
	localleader = "-", -- other commands
	indent_style = "tabs", -- tabs|spaces
	indent = 4, -- your indentation size

	lisp_filetypes = { "fennel", "lisp", "yuck" },
}

pcall(require, "impatient") --.enable_profile()

require("options")
vim.schedule(function()
	require("packages")
end)

-- vim.cmd("au VimLeave * set guicursor=a:hor20-blinkon0")
vim.schedule(function()
	vim.api.nvim_create_autocmd({ "VimLeave" }, {
		desc = "Set cursor to a blinking bar when leaving neovim.",
		callback = function()
			vim.opt.guicursor = "a:ver25-blinkon250"
		end,
	})
end)
