-- https://github.com/mhartington/formatter.nvim/
local function fnlfmt() return { exe = "fnlfmt", args = { "-" }, stdin = true } end
local function prettier()
  return {
    exe = "prettier",
    args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
    stdin = true,
  }
end

local function lua_format() return { exe = "lua-format", stdin = true } end

local function rustfmt()
  return { exe = "rustfmt", args = { "--emit=stdout" }, stdin = true }
end

local function stylish_haskell() return
  { exe = "stylish-haskell", stdin = true } end

require("formatter").setup {
  logging = false,
  filetype = {
    fennel = { fnlfmt },
    haskell = { stylish_haskell },
    javascript = { prettier },
    json = { prettier },
    lua = { lua_format },
    markdown = { prettier },
    rust = { rustfmt },
  },
}
