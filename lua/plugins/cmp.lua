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
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = true,
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
			"zbirenbaum/copilot-cmp",
			"onsails/lspkind.nvim",
			"L3MON4D3/LuaSnip",
		},
		opts = function()
			local cmp = require("cmp")
			local cmpr = cmp.config.compare
			local lspkind = require("lspkind")
			local luasnip = require("luasnip")

			local function has_words_before()
				if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
					return false
				end
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
			end

			local function tab_complete(fallback)
				if cmp.visible() and has_words_before() then
					cmp.select_next_item()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
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

			return {
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
				window = { documentation = { border = Settings.borderchars } },
				sorting = {
					comparators = {
						require("copilot_cmp.comparators").priortize,
						cmpr.offset,
						cmpr.exact,
						cmpr.score,
						cmpr.recently_used,
						require("cmp-under-comparator").under,
						cmpr.locality,
						cmpr.kind,
						cmpr.sort_text,
						cmpr.length,
						cmpr.order,
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
						symbol_map = { Copilot = "" },
					}),
				},
				experimental = { ghost_text = true },
			}
		end,
		config = true,
	},
}
