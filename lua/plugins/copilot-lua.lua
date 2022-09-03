local function setup()
	require("copilot").setup()
end

vim.defer_fn(setup, 100)
