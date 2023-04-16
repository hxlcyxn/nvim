return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = { "BufReadPost", "BufNewFile" },
	init = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldlevel = 42
	end,
	opts = {
		ensure_installed = "all",
		ignore_install = {
			"json",
			"jsonc",
		},
		highlight = {
			enable = true,
			use_languagetree = true,
			additional_vim_regex_highlighting = true,
		},
		indent = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
