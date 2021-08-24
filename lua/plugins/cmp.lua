local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")

require("cmp_nvim_lsp").setup()

local function feedkeys_t(str)
  vim.fn.feedkeys(vim.api.nvim_replace_termcodes(str, true, true, true), "")
end

local function tabcomplete(_, fallback)
  if vim.fn.pumvisible() == 1 then
    feedkeys_t("<C-n>")
  elseif luasnip.expand_or_jumpable() then
    feedkeys_t("<Plug>luasnip-expand-or-jump")
  else
    fallback()
  end
end

local function shifttabcomplete(_, fallback)
  if vim.fn.pumvisible() == 1 then
    feedkeys_t("<C-p>")
  elseif luasnip.jumpable(-1) then
    feedkeys_t("<Plug>luasnip-expand-or-jump")
  else
    fallback()
  end
end

cmp.setup {
  mapping = {
    ['<TAB>'] = cmp.mapping.mode({ "i", "s" }, tabcomplete),
    ['<S-TAB>'] = cmp.mapping.mode({ "i", "s" }, shifttabcomplete),
    ['<C-d>'] = cmp.mapping.scroll(-4),
    ['<C-f>'] = cmp.mapping.scroll(4),
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
