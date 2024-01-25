return {
	{
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
				"comment",
			},
			highlight = {
				enable = true,
				use_languagetree = true,
				additional_vim_regex_highlighting = true,
			},
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					node_incremental = "v",
					scope_incremental = "C-v",
					node_decremental = "V",
				},
			},
		},
		config = require("util").wrapsetup("nvim-treesitter.configs"),
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		depends = { "nvim-treesitter/nvim-treesitter" },
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			textobjects = {
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},
			},
		},
		config = require("util").wrapsetup("nvim-treesitter.configs"),
	},
}
