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
			-- "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
			"sontungexpt/better-diagnostic-virtual-text",
		},
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>mc", vim.lsp.buf.code_action, mode = { "n", "v" }, desc = "code actions" },
			{ "<leader>mh", show_docs, desc = "show documentation" },
			{ "<leader>mn", vim.lsp.buf.rename, desc = "rename node" },
			{ "<leader>mr", vim.lsp.buf.references, desc = "show references" },
			{ "<leader>ms", vim.lsp.buf.signature_help, desc = "signature help" },
			{ "<leader>mg", vim.lsp.buf.definition, desc = "go to definition" },
			{ "<leader>mi", vim.lsp.buf.implementation, desc = "show implementation" },
			{ "<leader>mf", vim.lsp.buf.format, desc = "format with lsp formatter" },
			{ "<C-S>", vim.lsp.buf.signature_help, mode = { "i" }, desc = "signature help" },
		},
		opts = {
			diagnostics = {
				virtual_text = false,
				-- virtual_lines = { only_current_line = true },
				signs = true,
				underline = true,
				update_in_insert = true,
				severity_sort = true,
			},
			servers = {
				clangd = {},
				helm_ls = {},
				html = {},
				jsonls = {},
				marksman = {},
				nil_ls = {},
				nixd = {},
				rust_analyzer = {},
				yamlls = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = { library = vim.api.nvim_get_runtime_file("", true), preloadFileSize = 200 },
							format = { enable = false },
							hint = { enabled = true },
							telemetry = { enabled = false },
						},
					},
				},
			},
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local buffer = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					if client == nil then
						return
					end

					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
					end

					require("better-diagnostic-virtual-text.api").setup_buf(buffer, {})
				end,
			})
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
		"mfussenegger/nvim-jdtls",
		event = "VimEnter",
		opts = function()
			local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
			local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/" .. project_name
			return {
				cmd = { "jdtls", "-data", workspace_dir },
				root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
			}
		end,
		config = function(_, opts)
			vim.api.nvim_create_autocmd({ "FileType" }, {
				pattern = "java",
				callback = function(_)
					require("jdtls").start_or_attach(opts)
				end,
			})
		end,
	},
	{
		"https://gitlab.com/schrieveslaach/sonarlint.nvim",
		enabled = false,
		dependencies = "nvim-jdtls",
		event = "VeryLazy",
		opts = {
			server = {
				cmd = {
					"sonarlint-ls",
					"stdio",
					"-analyzers",
					"/usr/share/java/sonarlint-ls/analyzers/sonarjava.jar",
				},
			},
			filetypes = {
				"java",
			},
		},
		config = true,
	},
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"ThePrimeagen/refactoring.nvim",
			{ "CKolkey/ts-node-action", dependencies = { "nvim-treesitter/nvim-treesitter" } },
		},
		event = { "BufReadPre", "BufNewFile" },
		opts = function()
			local null_ls = require("null-ls")

			return {
				border = Settings.border,
				sources = {
					null_ls.builtins.code_actions.refactoring,
					null_ls.builtins.code_actions.ts_node_action,

					null_ls.builtins.diagnostics.credo,
					null_ls.builtins.diagnostics.deadnix,
					null_ls.builtins.diagnostics.selene.with({
						condition = function(utils)
							return utils.root_has_file({ "selene.toml" })
						end,
					}),

					null_ls.builtins.formatting.alejandra,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.formatting.fnlfmt,
					null_ls.builtins.formatting.mix,
					null_ls.builtins.formatting.stylua,

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
	-- {
	-- 	"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
	-- 	config = true,
	-- },
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
		tag = "legacy",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			text = { spinner = "arc" },
		},
		config = true,
	},
}
