return {
	"vidocqh/data-viewer.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"kkharji/sqlite.lua", -- Optional, sqlite support
	},
	ft = { "csv", "tsv", "sqlite" },
	config = true,
}
