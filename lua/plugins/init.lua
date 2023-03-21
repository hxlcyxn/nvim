return {
	"folke/which-key.nvim",
	{
		"hxlcyxn/stargaze.nvim",
		lazy = false,
		config = function()
			vim.cmd("colorscheme stargaze")
		end,
	},
}
