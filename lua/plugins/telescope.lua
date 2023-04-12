local cmd = require("util").cmd

return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = { "Telescope" },
	keys = {
		{ "<leader>bf", cmd("Telescope buffers show_all_buffers=true"), desc = "open buffer list" },
		{ "<leader>fa", cmd("Telescope live_grep"), desc = "grep files" },
		{ "<leader>fb", cmd("Telescope buffers"), desc = "open buffer list" },
		{ "<leader>ff", cmd("Telescope find_files"), desc = "open file finder" },
		{ "<leader>fh", cmd("Telescope oldfiles"), desc = "open file history" },
	},
	opts = {
		dynamic_preview_title = true,
		defaults = {
			sorting_strategy = "ascending",
			layout_strategy = "bottom_pane",
			layout_config = {
				horizontal = {
					prompt_position = "bottom",
					mirror = false,
				},
				vertical = {
					prompt_position = "top",
					mirror = true,
				},
				bottom_pane = {
					prompt_position = "top",
					height = 0.4,
				},
				width = 0.8,
				height = 0.7,
			},
			file_ignore_patterns = {
				"node_modules",
				".git",
				".cache",
			},
			winblend = Settings.winblend,
			border = true,
			borderchars = Settings.borderchars,
			set_env = { ["COLORTERM"] = "truecolor" },
		},
	},
	config = true,
}
