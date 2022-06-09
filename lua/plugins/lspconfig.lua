-- https://github.com/neovim/nvim-lspconfig/
-- https://github.com/glepnir/lspsaga.nvim/
-- https://github.com/simrat39/rust-tools.nvim/
local lspconfig = require("lspconfig")
local lsp_util = require("lspconfig.util")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	underline = true,
	virtual_text = true,
	signs = true,
	update_in_insert = true,
})

local function on_attach(client, bufnr)
	require("lsp_signature").on_attach({
		bind = true,
		doc_lines = 0,
		hint_prefix = "ƒ ",
	}, bufnr)

	vim.b.omnifunc = "v:lua.vim.lsp.omnifunc"
	-- Keybindings for LSPs
	if client.supports_method("document_highlight") then
		vim.cmd([[hi LspReferenceRead gui=underline]])

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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local function init_lsp(name, extra_config)
	lspconfig[name].setup(
		vim.tbl_extend(
			"force",
			{ on_attach = on_attach, capabilities = capabilities, flags = { debounce_text_changes = 150 } },
			extra_config
		)
	)
end

local sumneko_runtime_path = vim.split(package.path, ";")
table.insert(sumneko_runtime_path, "/lua/?.lua")
table.insert(sumneko_runtime_path, "lua/?/init.lua")
-- table.insert(sumneko_runtime_path, vim.fn.stdpath("config") .. "/lua/?.lua")
-- table.insert(sumneko_runtime_path, vim.fn.stdpath("config") .. "lua/?/init.lua")

local servers = {
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT", path = sumneko_runtime_path },
				diagnostics = { globals = { "vim", "packer_plugins" } },
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
					args = { "-X", "compile", "%f" },
				},
			},
		},
	},
	eslint = {},
	hls = {},
	ltex = {},
	rnix = {},
	rust_analyzer = {},
	tsserver = {},
	vimls = {},
}

for server, config in pairs(servers) do
	init_lsp(server, config)
end
