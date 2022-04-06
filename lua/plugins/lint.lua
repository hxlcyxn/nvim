require("lint").linters_by_ft = {
	sh = { "shellcheck" },
}

vim.api.nvim_exec([[au BufWritePost <buffer> lua require('lint').try_lint()]], true)
vim.api.nvim_exec([[au TextChanged <buffer> lua require('lint').try_lint()]], true)
vim.api.nvim_exec([[au BufEnter <buffer> lua require('lint').try_lint()]], true)
