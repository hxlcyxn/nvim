local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

local function t(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local function check_back_space()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
end

local function tab_complete(fallback)
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(t("<C-n>"), "n")
  elseif luasnip.expand_or_jumpable() then
    vim.fn.feedkeys(t("<Plug>luasnip-expand-or-jump"), "")
  elseif check_back_space() then
    vim.fn.feedkeys(t("<TAB>"), "n")
  else
    fallback()
  end
end

local function shift_tab_complete(fallback)
  if vim.fn.pumvisible() == 1 then
    vim.fn.feedkeys(t("<C-p>"), "n")
  elseif luasnip.jumpable(-1) then
    vim.fn.feedkeys(t("<Plug>luasnip-jump-prev"), "")
  else
    fallback()
  end
end

require("cmp_nvim_lsp").setup()

cmp.setup {
  mapping = {
    ['<TAB>'] = cmp.mapping(tab_complete, { "i", "s" }),
    ['<S-TAB>'] = cmp.mapping(shift_tab_complete, { "i", "s" }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  documentation = { border = "solid" },
  sources = {
    { name = "buffer" },
    { name = "emoji" },
    { name = "latex_symbols" },
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "nvim_lua" },
    { name = "path" },
  },
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },
  formatting = {
    format = function(_, vim_item)
      vim_item.kind = lspkind.presets.default[vim_item.kind]
      return vim_item
    end,
  },
}
