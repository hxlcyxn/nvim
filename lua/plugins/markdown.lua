return {
	{
		"OXY2DEV/markview.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = function()
			local presets = require("markview.presets")
			return {
				modes = { "n", "i", "no", "c" },
				hybrid_modes = { "i" },
				callbacks = {
					on_enable = function(_, win)
						vim.wo[win].conceallevel = 2
						vim.wo[win].concealcursor = "c"
					end,
				},
				headings = presets.headings.glow_labels,
			}
		end,
		config = true,
	},
	{
		"tadmccorkle/markdown.nvim",
		ft = "markdown",
		opts = {},
		config = true,
	},
	{
		"ellisonleao/glow.nvim",
		cmd = "Glow",
		opts = {},
		config = true,
	},
}
