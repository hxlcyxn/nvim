require("colorizer").setup({
	filetypes = { "*", "!packer" },
	user_default_options = {
		RGB = true,
		RRGGBB = true,
		names = false,
		RRGGBBAA = true,
		AARRGGBB = true,
		rgb_fn = true,
		hsl_fn = true,
		mode = "virtualtext",
		tailwind = "both",
		sass = { enable = true },
		virtualtext = "■",
	},
})
