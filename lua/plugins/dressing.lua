return {
	"stevearc/dressing.nvim",
	-- dependencies = {
	-- 	"nvim-telescope/telescope.nvim",
	-- },
	event = "VeryLazy",
	opts = {
		input = { border = Settings.borderchars },
		select = {
			backend = "telescope",
			telescope = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.2,
					height = 0.3,
				},
				borderchars = Settings.borderchars,
			},
			get_config = function(opts)
				if opts.kind == "codeaction" then
					return { telescope = require("telescope.themes").get_cursor() }
				end
			end,
		},
	},
	config = true,
}
