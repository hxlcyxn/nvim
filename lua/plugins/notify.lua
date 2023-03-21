return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	opts = {
		stages = "fade_in_slide_out",
		render = "simple",
	},
	config = function(_, opts)
		require("notify").setup(opts)
		vim.notify = require("notify")
	end,
}
