local cmp = require("cmp")
local compare = require("cmp.config.compare")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function tab_complete(fallback)
	if cmp.visible() then
		cmp.select_next_item()
	elseif luasnip.expand_or_jumpable() then
		luasnip.expand_or_jump()
	elseif has_words_before() then
		cmp.complete()
	else
		fallback()
	end
end

local function shift_tab_complete(fallback)
	if cmp.visible() then
		cmp.select_prev_item()
	elseif luasnip.jumpable(-1) then
		luasnip.jump(-1)
	else
		fallback()
	end
end

cmp.setup({
	mapping = {
		["<TAB>"] = cmp.mapping(tab_complete, { "i", "s" }),
		["<S-TAB>"] = cmp.mapping(shift_tab_complete, { "i", "s" }),
		["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	},
	window = { documentation = { border = "solid" } },
	sorting = {
		comparators = {
			compare.offset,
			compare.exact,
			compare.score,
			require("cmp-under-comparator").under,
			compare.kind,
			compare.sort_text,
			compare.length,
			compare.order,
		},
	},
	sources = cmp.config.sources({
		{ name = "copilot" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "buffer" },
		{ name = "emoji" },
		{ name = "latex_symbols" },
		{ name = "crates" },
	}),
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	formatting = {
		format = lspkind.cmp_format({
			preset = "default",
			mode = "symbol",
			menu = {
				buffer = "[BUF]",
				cmdline = "[CMD]",
				copilot = "[COP]",
				path = "[PATH]",
				nvim_lsp = "[LSP]",
				nvim_lua = "[VIM]",
				luasnip = "[SNP]",
				emoji = "[EMO]",
				latex_symbols = "[LTX]",
			},
		}),
	},
	experimental = { ghost_text = true },
})

cmp.setup.cmdline(":", {
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
	view = {
		entries = {
			name = "wildmenu",
			separator = "|",
		},
	},
})
