-- https://github.com/b3nj5m1n/kommentary/
local wk = require("which-key")

vim.g.kommentary_create_default_mappings = false

wk.register(
  {
    c = {
      m = { "<Plug>kommentary_motion_default", "comment motion" },
      ["<space>"] = { "<Plug>kommentary_line_default", "comment line" },
      c = { "<Plug>kommentary_line_increase", "increase level" },
      d = { "<Plug>kommentary_line_decrease", "decrease level" },
    },
  }, { prefix = "<leader>", mode = "n" }
)
wk.register(
  {
    c = {
      ["<space>"] = { "<Plug>kommentary_visual_default", "comment motion" },
      c = { "<Plug>kommentary_visual_increase", "increase level" },
      d = { "<Plug>kommentary_visual_decrease", "decrease level" },
    },
  }, { prefix = "<leader>", mode = "v" }
)

require("kommentary.config").configure_language(
  "default", {
    prefer_single_line_comments = true,
    use_consistent_indentation = true,
    ignore_whitespace = true,
  }
)
