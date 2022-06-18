require("lint").linters_by_ft = {
	sh = { "shellcheck" },
	lua = { "selene" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "TextChanged", "BufEnter" }, {
	desc = "Lint supported files.",
	callback = function() require("lint").try_lint() end,
})
