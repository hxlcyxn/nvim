return {
	{
		"L3MON4D3/LuaSnip",
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		opts = {
			history = true,
			updateevents = "TextChanged,TextChangedI",
			region_check_events = "CursorHold",
			delete_check_events = "InsertLeave",
			enable_autosnippets = true,
		},
		config = function(_, opts)
			require("luasnip").config.set_config(opts)
			require("luasnip.loaders.from_vscode").lazy_load()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-path",
			"lukas-reineke/cmp-under-comparator",
			"saadparwaiz1/cmp_luasnip",
			"Saecki/crates.nvim",
			"onsails/lspkind.nvim",
			"L3MON4D3/LuaSnip",
		},
		opts = function()
			local cmp = require("cmp")
			local cmpr = cmp.config.compare
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")

			local function tab_complete(fb)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fb()
				end
			end

			local function shift_tab_complete(fb)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fb()
				end
			end

			return {
				mapping = {
					["<TAB>"] = cmp.mapping(tab_complete, {"i", "s" }),
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
				window = {documentation = { border = Settings.borderchars } },
				sorting = {
					comparators = {
						cmpr.offset,
						cmpr.exact,
						cmpr.score,
						require("cmp-under-comparator").under,
						cmpr.kind,
						cmpr.sort_text,
						cmpr.length,
						cmpr.order,
					},
				},
				sources = cmp.config.sources({
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
			}
		end,
		config = true,
	},
}
