return {
	{
		"hxlcyxn/stargaze.nvim",
		config = function()
			vim.cmd("colorscheme stargaze")
		end,
	},
	{
		"jghauser/mkdir.nvim",
		event = { "BufWritePre" },
	},
}
