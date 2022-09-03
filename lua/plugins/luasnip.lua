-- https://github.com/L3MON4D3/LuaSnip
require("luasnip").config.set_config({
	history = true,
	updateevents = "TextChanged,TextChangedI",
	region_check_events = "CursorHold",
	delete_check_events = "InsertLeave",
	enable_autsnippets = true,
})

require("luasnip.loaders.from_vscode").lazy_load()
