-- https://github.com/neovim/nvim-lspconfig/
-- https://github.com/glepnir/lspsaga.nvim/
-- https://github.com/simrat39/rust-tools.nvim/
local lspconfig = require("lspconfig")
local lsp_util = require("lspconfig.util")
local h = require("helpful")

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

	h.buf_setoption({ omnifunc = "v:lua.vim.lsp.omnifunc" })
	-- Keybindings for LSPs
	if client.resolved_capabilities.document_highlight then
		vim.api.nvim_exec(
			[[
    hi LspReferenceRead gui=underline

    augroup lsp_document_highlight
      autocmd! * <buffer>
      autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
      autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
    augroup END
    ]],
			false
		)
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
	clangd = {},
	hls = {},
	rnix = {},
	rust_analyzer = {},
	tsserver = {},
	vimls = {},
}

for server, config in pairs(servers) do
	init_lsp(server, config)
end
