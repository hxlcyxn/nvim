local function setup()
	require("copilot").setup({
		cmp_method = "getPanelCompletions",
	})
end

vim.defer_fn(setup, 100)
