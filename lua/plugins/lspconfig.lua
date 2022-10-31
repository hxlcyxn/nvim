-- https://github.com/neovim/nvim-lspconfig/
-- https://github.com/glepnir/lspsaga.nvim/
-- https://github.com/simrat39/rust-tools.nvim/
local lspconfig = require("lspconfig")
local lsp_util = require("lspconfig.util")

-- vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
-- 	underline = true,
-- 	virtual_text = true,
--signs = true,
-- 	update_in_insert = true,
-- })

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = { only_current_line = true },
	signs = true,
	underline = true,
	update_in_insert = true,
	severity_sort = true,
})

local function on_attach(client, bufnr)
	require("lsp_signature").on_attach({
		bind = true,
		doc_lines = 0,
		hint_prefix = "ƒ ",
	}, bufnr)

	vim.b.omnifunc = "v:lua.vim.lsp.omnifunc"

	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_set_hl(0, "LspReferenceRead", { undercurl = true })

		local augroup_name = "lsp_document_highlight"
		vim.api.nvim_create_augroup(augroup_name, { clear = false })
		vim.api.nvim_clear_autocmds({ buffer = bufnr, group = augroup_name })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			desc = "Highlight references to name under cursor.",
			group = augroup_name,
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			desc = "Clear highlight to name under cursor.",
			group = augroup_name,
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local function init_lsp(name, extra_config)
	lspconfig[name].setup(
		vim.tbl_extend(
			"force",
			{ on_attach = on_attach, capabilities = capabilities, flags = { debounce_text_changes = 150 } },
			extra_config
		)
	)
end

local servers = {
	sumneko_lua = {
		settings = {
			Lua = {
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					preloadFileSize = 200,
				},
				hint = { enable = true },
				telemetry = { enabled = false },
			},
		},
	},
	jsonls = { settings = { json = { schemas = require("schemastore").json.schemas() } } },
	elixirls = {
		cmd = { "elixir-ls" },
		settings = { elixirLS = { dialyzerEnabled = false, fetchDeps = false } },
		on_attach = function(client, bufnr)
			on_attach(client, bufnr)
			local function pipes(direction)
				local rowcol = vim.api.nvim_win_get_cursor(0)
				local row = rowcol[1] - 1
				local col = rowcol[2]

				client.request_sync("workspace/executeCommand", {
					command = "manipulatePipes:serverid",
					arguments = { direction, "file://" .. vim.api.nvim_buf_get_name(0), row, col },
				}, nil, 0)
			end

			local cmd = vim.api.nvim_buf_create_user_command
			cmd(bufnr, "ElixirFromPipe", function()
				pipes("fromPipe")
			end, {})
			cmd(bufnr, "ElixirToPipe", function()
				pipes("toPipe")
			end, {})
		end,
	},
	powershell_es = {
		bundle_path = "/opt/powershell-editor-services",
	},
	texlab = {
		root_dir = function(fname)
			return lsp_util.root_pattern(".latexmkrc")(fname)
				or lsp_util.root_pattern("Tectonic.toml")(fname)
				or lsp_util.find_git_ancestor(fname)
		end,
		settings = {
			texlab = {
				build = {
					executable = "tectonic",
					args = { "-X", "compile", "%f", "--synctex", "--keep-logs", "--keep-intermediates" },
				},
			},
		},
	},
	yamlls = {
		settings = {
			yaml = {
				schemas = (function()
					local json_schemas = require("schemastore").json.schemas()
					local yaml_schemas = {}
					vim.tbl_map(function(schema)
						yaml_schemas[schema.url] = schema.fileMatch
					end, json_schemas)
					return yaml_schemas
				end)(),
			},
		},
	},
	astro = {},
	dockerls = {},
	eslint = {},
	hls = {},
	ltex = {},
	marksman = {},
	rnix = {},
	tailwindcss = {},
	taplo = {},
	tsserver = {},
	vimls = {},
}

for server, config in pairs(servers) do
	init_lsp(server, config)
end
