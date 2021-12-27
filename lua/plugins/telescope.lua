-- https://github.com/nvim-telescope/telescope.nvim/
require("telescope").setup({
	defaults = {
		sorting_strategy = "ascending",
		layout_strategy = "bottom_pane",
		layout_config = {
			prompt_position = "top",
			horizontal = { mirror = false },
			vertical = { mirror = false },
			bottom_pane = { height = 15 },
		},
		file_ignore_patterns = { "node_modules" },
		winblend = 10,
		border = true,
		borderchars = { -- for bottom_pane
			"z",
			prompt = { "─", " ", " ", " ", "─", "─", " ", " " },
			results = { " " },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			-- preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		},
		-- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		-- borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
	},
})

require("telescope").load_extension("ui-select")
