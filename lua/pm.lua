local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--single-branch",
		"git@github.com:folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("plugins", {
	defaults = {
		lazy = true,
	},
	dev = {
		path = "~/src",
		patterns = {
			"hxlcyxn",
		},
		fallback = true,
	},
	install = { colorscheme = { "stargaze", "quiet" } },
	ui = {
		border = Settings.border,
	},
	checker = {
		enabled = true,
	},
	performance = {
		rtp = {
			disabled_plugins = {
				"2html_plugin",
				"getscript",
				"getscriptPlugin",
				"gzip",
				"logipat",
				"matchit",
				"matchparen",
				"netrwFileHandlers",
				"netrwPlugin",
				"netrwSettings",
				"rrhelper",
				"tar",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})

local cmd = require("util").cmd
vim.api.nvim_set_keymap("n", "<leader>Ll", cmd("Lazy"), { desc = "open lazy.nvim dashboard" })
