return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		indent = {
			char = "▏",
		},
	},
	main = "ibl",
	config = true,
}
