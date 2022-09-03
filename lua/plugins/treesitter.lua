-- https://github.com/nvim-treesitter/nvim-treesitter/
-- https://github.com/p00f/nvim-ts-rainbow
require("nvim-treesitter.configs").setup({
	ensure_installed = "all",
	highlight = { enable = true, use_languagetree = true, additional_vim_regex_highlighting = true },
	indent = { enable = true },
})

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

local M = {}

M.autopairs = function()
	require("nvim-treesitter.configs").setup({ autopairs = { enable = true } })
end

M.autotag = function()
	require("nvim-treesitter.configs").setup({
		autotag = {
			enable = true,
			-- filetypes = { "html", "xml" }, -- rip, no xml ts parser
		},
	})
end

M.playground = function()
	require("nvim-treesitter.configs").setup({ playground = { enable = true } })
	require("nvim-treesitter.configs").setup({
		query_linter = {
			enable = true,
			use_virtual_text = true,
			lint_events = { "BufWrite", "CursorHold" },
		},
	})
end

M.rainbow = function()
	require("nvim-treesitter.configs").setup({
		rainbow = {
			enable = true,
			extended_mode = true,
			colors = {
				"#D96C75",
				"#C2D94C",
				"#E6B673",
				"#59C2FF",
				"#D4BFFF",
				"#95E6CB",
				"#FF3333",
				"#91B362",
				"#FF8F40",
				"#6994BF",
				"#A37ACC",
				"#39BAE6",
				"#E6E7E9",
			},
			termcolors = {
				"LightRed",
				"LightGreen",
				"LightYellow",
				"LightBlue",
				"LightMagenta",
				"LightCyan",
				"LightGrey",
				"Red",
				"Green",
				"Yellow",
				"Blue",
				"Magenta",
				"Cyan",
				"White",
			},
		},
	})
end

M.context = function()
	require("treesitter-context").setup()
end

M.commentstring = function()
	require("nvim-treesitter.configs").setup({
		context_commentstring = {
			enable = true,
			enable_autocmd = false,
		},
	})
end

M.textobjects = function()
	require("nvim-treesitter.configs").setup({
		textobjects = {
			select = { enable = true },
			lookahead = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
			}
		},
	})
end

return M
