return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	event = {"BufReadPost", "BufNewFile" },
	init = function()
		vim.opt.foldmethod = "expr"
		vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
		vim.opt.foldlevel = 42
	end,
	opts = {
		ensure_installed = {
			"astro",
			"c",
			"comment",
			"cpp",
			"css",
			"elixir",
			"fennel",
			"git_rebase",
			"gitattributes",
			"gitcommit",
			"gitignore",
			"help",
			"html",
			"ini",
			"javascript",
			"jsdoc",
			"json5",
			"latex",
			"lua",
			"make",
			"markdown",
			"markdown_inline",
			"nix",
			"python",
			"query",
			"rust",
			"scss",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"yaml",
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
