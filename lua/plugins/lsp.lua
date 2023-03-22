local function show_docs()
	local contains = vim.tbl_contains
	local ft = vim.bo.filetype
	local cword = vim.fn.expand("<cword>")
	local filename = vim.fn.expand("%:t")
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
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"williamboman/mason.nvim",
			"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		keys = {
			{ "<leader>mc", vim.lsp.buf.code_action, desc = "code actions" },
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

			-- local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
			local capabilities = vim.lsp.protocol.make_client_capabilities()

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, opts.servers[server] or {})

				require("lspconfig")[server].setup(server_opts)
			end

			local mlsp = require("mason-lspconfig")
			local available = mlsp.get_available_servers() or {}

			local ensure_installed = {}
			for server, server_opts in pairs(opts.servers) do
				if server_opts then
					if not vim.tbl_contains(available, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			mlsp.setup({ ensure_installed = ensure_installed })
			mlsp.setup_handlers({ setup })
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"williamboman/mason.nvim",
			"jose-elias-alvarez/null-ls.nvim",
		},
		opts = {
			ensure_installed = { "stylua" },
			automatic_setup = true,
		},
		config = function(_, opts)
			require("mason-null-ls").setup(opts)
			require("null-ls").setup()
			require("mason-null-ls").setup_handlers()
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		opts = {
			ui = {
				border = Settings.borderchars,
				width = 0.8,
				height = 0.7,
			},
		},
		config = true,
	},
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
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
