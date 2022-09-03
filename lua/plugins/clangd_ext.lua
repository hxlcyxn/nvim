require("clangd_extensions").setup({
	extensions = {
		inlay_hints = {
			parameter_hints_prefix = "ᐊ",
			other_hints_prefix = "»",
		},
		memory_usage = { border = "single" },
		symbol_info = { border = "single" },
	},
})
