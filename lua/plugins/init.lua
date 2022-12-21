return {
	"folke/which-key.nvim",
	{
		"monkoose/matchparen.nvim",
		config = function()
			require("matchparen").setup()
		end,
	},
	{
		"hxlcyxn/stargaze.nvim",
		lazy = false,
		config = function()
			vim.cmd("colorscheme stargaze")
		end,
	},
}
