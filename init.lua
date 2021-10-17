_G.Utils = {}
_G.Commands = {}

_G.Settings = {
  colorscheme = "ayu", -- "ayu"|"xresources"
  background = "dark", -- "dark"|"light"

  ayu_mirage = false, -- true|false

  mapleader = ' ', -- affects basically all commands, most important button
  indent = 2, -- your indentation size, spaces > tabs
}

if package.loaded["impatient"] then require("impatient").enable_profile() end

require("options")
require("packages")

vim.cmd("au VimLeave * set guicursor=a:hor20-blinkon0")
