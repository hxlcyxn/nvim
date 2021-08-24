if _G.Settings.background == "light" then
  vim.o.background = "light"
else
  vim.o.background = "dark"
end

-- Colorscheme-dependent functions {{{

local function luxed_ayu()
  vim.g.ayucolor = "dark"

  vim.api.nvim_exec(
    [[
  augroup custom_colors
    autocmd!
    autocmd ColorScheme ayu call ayu#hi("MatchParen", "markup", "gutter_normal", "bold")
  augroup END
  ]], true
  )

  vim.api.nvim_exec("colorscheme ayu", true)
end

local function nvim_ayu()
  local colors = require("ayu.colors")
  vim.g.ayu_overrides = {
    MatchParen = { fg = colors.markup, bg = colors.gutter_normal,
                   style = "bold" },
  }

  vim.api.nvim_exec("colorscheme ayu", true)
end

local function xresources()
  local xres = require("xresources")

  xres.highlight(
    "MatchParen", { fg = xres.red, bg = xres.grey1, style = "bold" }
  )
end

-- }}}

if _G.Settings.colorscheme == "ayu" then
  if _G.Settings.ayu_ver == "luxed" then
    luxed_ayu()
  elseif _G.Settings.ayu_ver == "nvim" then
    nvim_ayu()
  end
elseif _G.Settings.colorscheme == "xresources" then
  xresources()
end
