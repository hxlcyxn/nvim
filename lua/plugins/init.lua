return {
	{
		"hxlcyxn/stargaze.nvim",
		lazy = false,
		config = function()
			vim.cmd("colorscheme stargaze")
		end,
	},
	{
		"jghauser/mkdir.nvim",
		event = { "BufWritePre" },
	},
}
