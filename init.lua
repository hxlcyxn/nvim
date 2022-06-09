_G.Utils = {}
_G.Commands = {}

_G.Settings = {
	colorscheme = "ayu", -- "ayu"|"xresources"
	background = "dark", -- "dark"|"light"

	ayu_mirage = false, -- true|false

	mapleader = " ", -- affects basically all commands, most important button
	localleader = "-", -- other commands
	indent_style = "tabs", -- tabs|spaces
	indent = 4, -- your indentation size
}

require("impatient")--.enable_profile()

require("options")
require("packages")

-- vim.cmd("au VimLeave * set guicursor=a:hor20-blinkon0")
vim.cmd("au VimLeave * set guicursor=a:ver25-blinkon250")
