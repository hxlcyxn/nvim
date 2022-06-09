vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
	desc = "Update nvim-lightbulb.",
	pattern = "*",
	callback = require("nvim-lightbulb").update_lightbulb,
})
