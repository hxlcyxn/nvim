-- https://github.com/mhartington/formatter.nvim/
local function fnlfmt()
	return { exe = "fnlfmt", args = { "-" }, stdin = true }
end

local function prettier()
	local startpath = vim.fn.getcwd()
	local root = require("lspconfig.util").find_node_modules_ancestor(startpath)
		or require("lspconfig.util").find_package_json_ancestor(startpath)
		or require("lspconfig.util").find_git_ancestor(startpath)

	local exe = "prettier"
	if root then
		exe = root .. "/node_modules/.bin/" .. exe
	end

	return {
		exe = exe,
		args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0) },
		stdin = true,
	}
end

local function stylish_haskell()
	return { exe = "stylish-haskell", stdin = true }
end

local function mix_format()
	return {
		exe = "mix",
		args = { "format", "-" },
		stdin = true,
	}
end

local function alejandra()
	return {
		exe = "alejandra",
		args = { "" },
		stdin = true,
	}
end

require("formatter").setup({
	logging = false,
	filetype = {
		astro = { prettier },
		c = { require("formatter.filetypes.c").clangformat },
		elixir = { mix_format },
		fennel = { fnlfmt },
		haskell = { stylish_haskell },
		html = { prettier },
		javascript = { prettier },
		json = { prettier },
		jsonc = { prettier },
		lua = { require("formatter.filetypes.lua").stylua },
		markdown = { prettier },
		nix = { alejandra },
		python = { require("formatter.filetypes.python").black },
		rust = { require("formatter.filetypes.rust").rustfmt },
		toml = { require("formatter.filetypes.toml").taplo },
		typescript = { require("formatter.filetypes.typescript").prettier },
	},
})
