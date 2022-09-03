require("mkdnflow").setup({
	wrap = true,
	links = {
		transform_explicit = function(text)
			return text:gsub(" ", "-"):lower()
		end,
	},
	mappings = {
		MkdnEnter = { { "i", "n", "v" }, "<CR>" },
	},
})
