local M = {}

M.ayu_light = {
  fg = "#575f66",
  fg2 = "#eff0f1",
  bg1 = "#cdd0d3",
  bg2 = "#ffffff",
  red = "#f51818",
  green = "#99bf4d",
  yellow = "#ff9940",
  blue = "#709ecc",
  purple = "#a37acc",
  cyan = "#4cbf99",
}

M.ayu_dark = {
  fg = "#b3b1ad",
  fg2 = "#00010a",
  bg1 = "#323945",
  bg2 = "#0d1016",
  red = "#ff3333",
  green = "#91b362",
  yellow = "#ff8f40",
  blue = "#6994bf",
  purple = "#a37acc",
  cyan = "#95e6cb",
}

-- NOTE: when xresources is required it automatically sets the colorscheme so you can"t require it always
if _G.Settings.colorscheme == "xresources" then
  local xres = require("xresources")
  M.xresources = {
    fg1 = xres.fg,
    fg2 = _G.Settings.background == "light" and xres.white or xres.black,
    bg1 = xres.grey1,
    bg2 = xres.grey,
    red = xres.red,
    green = xres.green,
    yellow = xres.yellow,
    blue = xres.blue,
    purple = xres.purple,
    cyan = xres.light_cyan,
  }
end

function M.colour(val)
  return function()
    if _G.Settings.colorscheme == "ayu" then
      if _G.Settings.background == "light" then
        return M.ayu_light[val]
      elseif _G.Settings.background == "dark" then
        return M.ayu_dark[val]
      end
    elseif _G.Settings.colorscheme == "xresources" then
      return M.xresources[val]
    end
  end
end

function M.get_colour(val)
  if _G.Settings.colorscheme == "ayu" then
    if _G.Settings.background == "light" then
      return M.ayu_light[val]
    elseif _G.Settings.background == "dark" then
      return M.ayu_dark[val]
    end
  elseif _G.Settings.colorscheme == "xresources" then
    return M.xresources[val]
  end
end

return M
