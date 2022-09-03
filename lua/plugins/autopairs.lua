-- https://github.com/windwp/nvim-autopairs/
local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
	disable_filetype = { "TelescopePrompt", unpack(Settings.lisp_filetypes)},
	check_ts = true,
	fast_wrap = {},
})

-- LuaFormatter off
npairs.add_rules({
	Rule(" ", " "):with_pair(function(opts)
		local pair = opts.line:sub(opts.col, opts.col + 1)
		return vim.tbl_contains({ "()", "[]", "{}" }, pair)
	end),
})
-- LuaFormatter on

require("plugins.treesitter").autopairs()

local cmp_ap = require("nvim-autopairs.completion.cmp")
local cmp = require("cmp")
cmp.event:on("confirm_done", cmp_ap.on_confirm_done())
