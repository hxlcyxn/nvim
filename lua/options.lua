vim.api.nvim_exec2("filetype plugin indent on", { output = false })
vim.api.nvim_exec2("syntax enable", { output = false })

vim.g.mapleader = Settings.mapleader
vim.g.maplocalleader = Settings.localleader

vim.opt.clipboard = "unnamedplus"

vim.opt.shortmess:append("I")

vim.opt.title = true
vim.opt.titlestring = "%t - nvim"

vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5

vim.opt.mouse = "a"
vim.o.mousemoveevent = true
vim.opt.termguicolors = true
vim.opt.background = Settings.background
vim.opt.winblend = Settings.winblend
vim.opt.pumblend = Settings.pumblend

vim.opt.laststatus = 3

vim.opt.signcolumn = "yes"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 2
vim.opt.cursorline = false
vim.opt.cmdheight = 0

vim.opt.list = true
vim.opt.listchars = "tab:▏ ,trail:·" -- ",eol:↲" -- → ↵↲⏎

vim.opt.conceallevel = 2

vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "shift:2"
vim.opt.showbreak = "> "
vim.opt.whichwrap:append("<>hl")

vim.opt.tabstop = Settings.indent
vim.opt.softtabstop = Settings.indent
vim.opt.shiftwidth = Settings.indent
vim.opt.smartindent = true
vim.opt.copyindent = false
if Settings.indent_style == "spaces" then
	vim.opt.expandtab = true
end

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

vim.opt.guifont = ("%s:h%d"):format(Settings.guifont, Settings.fontsize)

vim.opt.fillchars = "eob: "

vim.api.nvim_create_autocmd("BufWritePost", {
	desc = [[Make files with shebang lines user executable.]],
	callback = function(table)
		local first_line = vim.api.nvim_buf_get_lines(table.buf, 0, 1, false)[1] or ""
		if string.find(first_line, "^#!%s*[^%s]") then
			local perms = vim.fn.getfperm(table.file)
			-- replace the third character with an x
			perms = ("%s%s%s"):format(perms:sub(1, 2), "x", perms:sub(4))
			vim.fn.setfperm(table.file, perms)
		end
	end,
})
