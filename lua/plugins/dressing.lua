return {
	"stevearc/dressing.nvim",
	-- dependencies = {
	-- 	"nvim-telescope/telescope.nvim",
	-- },
	event = "VeryLazy",
	opts = {
		input = { border = Settings.border },
		select = {
			backend = "telescope",
			telescope = {
				layout_strategy = "horizontal",
				layout_config = {
					width = 0.5,
					height = 0.4,
				},
				borderchars = Settings.border,
			},
			get_config = function(opts)
				if opts.kind == "codeaction" then
					return { telescope = require("telescope.themes").get_cursor({ borderchars = Settings.border }) }
				end
			end,
		},
	},
	config = true,
}
