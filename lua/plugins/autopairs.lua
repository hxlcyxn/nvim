-- https://github.com/windwp/nvim-autopairs/
local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup {
  disable_filetype = { "TelescopePrompt", "fennel", "lisp", "yuck" },
  check_ts = true,
  fast_wrap = {},
}

-- LuaFormatter off
npairs.add_rules {
  Rule(" ", " ")
    :with_pair(function(opts)
      local pair = opts.line:sub(opts.col, opts.col + 1)
      return vim.tbl_contains({ "()", "[]", "{}" }, pair)
    end),
}
-- LuaFormatter on

require("plugins.treesitter").autopairs()

require("nvim-autopairs.completion.cmp").setup {
  map_cr = true, --  map <CR> on insert mode
  map_complete = true, -- it will auto insert `(` after select function or method item
}
