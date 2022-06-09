-- https://github.com/mhartington/formatter.nvim/
local function fnlfmt()
	return { exe = "fnlfmt", args = { "-" }, stdin = true }
end
local function prettier()
	return {
		exe = "prettier",
		args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

local function stylish_haskell()
	return { exe = "stylish-haskell", stdin = true }
end

require("formatter").setup({
	logging = false,
	filetype = {
		c = { require("formatter.filetypes.c").clangformat },
		fennel = { fnlfmt },
		haskell = { stylish_haskell },
		javascript = { require("formatter.filetypes.javascript").prettier },
		json = { require("formatter.filetypes.json").prettier },
		jsonc = { require("formatter.filetypes.json").prettier },
		lua = { require("formatter.filetypes.lua").stylua },
		markdown = { prettier },
		rust = { require("formatter.filetypes.rust").rustfmt },
		typescript = { require("formatter.filetypes.typescript").prettier },
	},
})
