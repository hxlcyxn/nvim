local cmd = require("util").cmd

local function show_docs()
	local contains = vim.tbl_contains
	local ft = vim.bo.filetype
	local cword = vim.fn.expand("<cword>")
	if contains({ "vim", "help" }, ft) then
		vim.cmd("h " .. cword)
	elseif contains({ "man" }, ft) then
		vim.cmd("Man " .. cword)
	else
		vim.lsp.buf.hover()
	end
end

return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>mc", vim.lsp.buf.code_action, mode = { "n", "v" }, desc = "code actions" },
			{ "<leader>mh", show_docs, desc = "show documentation" },
			{ "<leader>mr", vim.lsp.buf.rename, desc = "rename node" },
			{ "<leader>ms", vim.lsp.buf.signature_help, desc = "signature help" },
			{ "<leader>mg", vim.lsp.buf.definition, desc = "go to definition" },
			{ "<leader>mi", vim.lsp.buf.implementation, desc = "show implementation" },
			{ "<leader>mf", vim.lsp.buf.format, desc = "format with lsp formatter" },
		},
		opts = {
			diagnostics = {
				virtual_text = false,
				virtual_lines = { only_current_line = true },
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = true,
			},
			servers = {
				jsonls = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								library = vim.api.nvim_get_runtime_file("", true),
								preloadFileSize = 200,
							},
							format = { enable = false },
							hint = { enabled = true },
							telemetry = { enabled = false },
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.diagnostic.config(opts.diagnostics)

			local capabilities = vim.lsp.protocol.make_client_capabilities()

			for server, server_opts in pairs(opts.servers) do
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, server_opts or {})

				require("lspconfig")[server].setup(server_opts)
			end
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = {
			"ThePrimeagen/refactoring.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local null_ls = require("null-ls")

			return {
				border = Settings.borderchars,
				sources = {
					null_ls.builtins.code_actions.gitsigns,
					null_ls.builtins.code_actions.ltrs,
					null_ls.builtins.code_actions.refactoring,
					null_ls.builtins.code_actions.shellcheck,
					null_ls.builtins.code_actions.statix,

					null_ls.builtins.diagnostics.clang_check,
					null_ls.builtins.diagnostics.credo,
					null_ls.builtins.diagnostics.deadnix,
					null_ls.builtins.diagnostics.ltrs,
					null_ls.builtins.diagnostics.selene,
					null_ls.builtins.diagnostics.shellcheck,
					null_ls.builtins.diagnostics.statix,

					null_ls.builtins.formatting.alejandra,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.fnlfmt,
					null_ls.builtins.formatting.mix,
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.taplo,

					null_ls.builtins.hover.dictionary,
					null_ls.builtins.hover.printenv,
				},
			}
		end,
		config = true,
	},
	{
		"folke/trouble.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		cmd = "Trouble",
		keys = {
			{ "<leader>me", cmd("Trouble workspace_diagnostics"), desc = "show diagnostics" },
		},
		config = true,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = true,
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			{ "SmiteshP/nvim-navic", dependencies = { "neovim/nvim-lspconfig" } },
			"nvim-tree/nvim-web-devicons",
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		config = true,
	},
	{
		"j-hui/fidget.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			text = { spinner = "arc" },
		},
		config = true,
	},
}
