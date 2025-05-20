return {
	"saghen/blink.cmp",
	dependencies = {
		"rafamadriz/friendly-snippets",
	},
	version = "1.*",
	opts = {
		keymap = {
			preset = "enter",
			appearance = {
				nerd_font_variant = "mono",
			},
		},
		completion = {
			documentation = {
				auto_show = true,
				auto_showdelay_ms = 0,
			},
			keyword = {
				range = "full",
			},
			trigger = {
				show_on_keyword = false,
				show_on_trigger_character = false,
				show_on_insert_on_trigger_character = false,
				show_on_accept_on_trigger_character = false,
			},
			menu = {
				auto_show = false,
			},
			ghost_text = {
				enabled = true,
			},
		},
		signature = {
			enabled = true,
		},
		cmdline = {
			enabled = true,
		},
	},
	config = true,
}
