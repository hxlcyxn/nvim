require("luasnip").config.set_config({
	history = false,
	updateevents = "TextChanged,TextChangedI",
	region_check_events = "CursorHold",
	delete_check_events = "InsertLeave",
})

require("luasnip.loaders.from_vscode").lazy_load()
