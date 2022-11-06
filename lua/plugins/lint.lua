require("lint").linters_by_ft = {
	elixir = { "credo" },
	lua = { "selene" },
	nix = { "statix" },
	sh = { "shellcheck" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "BufEnter" }, {
	desc = "Lint supported files.",
	callback = function()
		require("lint").try_lint()
	end,
})
