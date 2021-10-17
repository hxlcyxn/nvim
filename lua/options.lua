vim.api.nvim_exec("filetype plugin indent on", true)
vim.api.nvim_exec("syntax enable", true)

vim.g.mapleader = _G.Settings.mapleader

vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5

vim.opt.mouse = "a"
vim.opt.termguicolors = true
if _G.Settings.background == "light" then
  vim.opt.background = "light"
else
  vim.opt.background = "dark"
end

vim.opt.laststatus = 2

vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.numberwidth = 2
vim.opt.cursorline = true

vim.opt.list = true
vim.opt.listchars = "tab:→ ,trail:·,eol:↲" -- ↵↲⏎

vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2"
vim.opt.showbreak = "> "
vim.opt.whichwrap:append("<>hl")

vim.opt.tabstop = _G.Settings.indent
vim.opt.softtabstop = _G.Settings.indent
vim.opt.shiftwidth = _G.Settings.indent
vim.opt.smartindent = true
vim.opt.copyindent = false
vim.opt.expandtab = true

vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.updatetime = 100

vim.opt.backspace = "indent,eol,start"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.hidden = true

vim.opt.shortmess:append("c")

vim.opt.guifont = "FiraCode NF:h14"

vim.cmd("let &fcs='eob: '")
