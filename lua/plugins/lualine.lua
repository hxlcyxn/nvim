return {
	"nvim-lualine/lualine.nvim",
	dependecies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	opts = {
		options = {
			theme = "stargaze",
			component_separators = "",
			section_separators = "",
			globalstatus = true,
		},
		sections = {
			lualine_a = { "mode" },
			lualine_b = { { "filename", path = 1 } },
			lualine_c = { "d1iagnostics" },
			lualine_x = { "searchcount" },
			lualine_y = { { "diff" }, { "branch" } },
			lualine_z = { "location" },
		},
	},
	config = true,
}
