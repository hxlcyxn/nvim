local feline = require("feline")

local colorscheme = _G.Settings.colorscheme
if colorscheme == "ayu" then
  colorscheme = colorscheme .. "_" .. _G.Settings.background
end

local cl = require("plugins.colours")[colorscheme]

local components = { active = {}, inactive = {} }

local vi_mode_colors = {
  NORMAL = "yellow",
  OP = "yellow",
  INSERT = "blue",
  VISUAL = "purple",
  BLOCK = "purple",
  SELECT = "cyan",
  COMMAND = "yellow",
  REPLACE = "red",
  ["V-REPLACE"] = "red",
  TERM = "blue",
}

local function sep(separator, fg, bg)
  if not separator then separator = " " end
  return { provider = separator, hl = { fg = fg, bg = bg } }
end

local vi_mode = {
  provider = "vi_mode",
  hl = function()
    return {
      name = require("feline.providers.vi_mode").get_mode_highlight_name(),
      fg = require("feline.providers.vi_mode").get_mode_color(),
      style = "bold",
    }
  end,
  icon = "",
}

local filename = { provider = "file_info", type = "relative-short" }

local git_branch = { provider = "git_branch" }

local position = { provider = "position", hl = { fg = "yellow" } }

local line_percentage = { provider = "line_percentage", hl = { fg = "yellow" } }

components.active[1] = { vi_mode, sep " ", filename }
components.active[2] = {}
components.active[3] = {
  git_branch,
  sep " ",
  position,
  sep("│", "orange"),
  line_percentage,
}

feline.setup {
  colors = cl,
  vi_mode_colors = vi_mode_colors,
  default_bg = "bg2",
  default_fg = "fg1",
  components = components,
}

vim.opt.showmode = false
