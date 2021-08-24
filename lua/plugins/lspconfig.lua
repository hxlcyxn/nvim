-- https://github.com/neovim/nvim-lspconfig/
-- https://github.com/glepnir/lspsaga.nvim/
-- https://github.com/simrat39/rust-tools.nvim/
local lspconfig = require("lspconfig")
local h = require("helpful")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = true,
      signs = true,
      update_in_insert = true,
    }
  )

local on_attach = function(client)
  require("lsp_signature").on_attach {
    bind = false, -- true if without lspsaga
    doc_lines = 3,
    hint_enable = true,
    hint_prefix = "ƒ ",
    use_lspsaga = true,
  }

  h.buf_setoption { omnifunc = "v:lua.vim.lsp.omnifunc" }
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
    ]], false
    )
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.documentationFormat =
-- { 'markdown' }
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport =
  true
capabilities.textDocument.completion.completionItem.tagSupport =
  { valueSet = { 1 } }
capabilities.textDocument.completion.completionItem.resolveSupport =
  { properties = { 'documentation', 'detail', 'additionalTextEdits' } }

local sumneko_root_path = "/home/" .. vim.fn.expand("$USER")
                            .. "/src/lua-language-server"
local sumneko_binary = sumneko_root_path .. "/bin/Linux/lua-language-server"
local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "/lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
table.insert(runtime_path, vim.fn.stdpath("config") .. "/lua/?.lua")
table.insert(runtime_path, vim.fn.stdpath("config") .. "lua/?/init.lua")

lspconfig.sumneko_lua.setup {
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/main.lua" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT", path = runtime_path },
      diagnostics = { globals = { "vim", "packer_plugins" } },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        preloadFileSize = 200,
      },
      hint = { enable = true },
      telemetry = { enabled = false },
    },
  },
  on_attach = on_attach,
  capabilities = capabilities,
}

local servers = {
  -- "ccls",
  "clangd",
  "hls",
  "jsonls",
  "rnix",
  "rust_analyzer",
  "tsserver",
  "vimls",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
  }
end
