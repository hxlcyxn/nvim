local M = {}

--- Sets specified vim options.
---@deprecated
---@param opts table: Options to be set. Keys: options
function M.setoption(opts)
	for option, value in pairs(opts) do
		vim.o[option] = value
	end
end

--- Sets specified vim options buffer-local.
---@deprecated
---@param opts table: Options to be set. Keys: options
function M.buf_setoption(opts)
	for option, value in pairs(opts) do
		vim.bo[option] = value
	end
end

--- Sets specified variables as global vim variables
---@deprecated
---@param globs table: Globals to be set. Keys: globals
function M.setglobal(globs)
	for global, value in pairs(globs) do
		vim.g[global] = value
	end
end

--- Sets a key mapping.
--- Light wrapper around vim.api.nvim_set_keymap(). Automatically sets silent to true.
---@param mode string: character defining the vim mode. empty for all
---@param lhs string: the key combination
---@param rhs string: the action to execute
---@param opts table: options passed to the function
function M.map(mode, lhs, rhs, opts)
	local options = { silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--- Sets a noremap key mapping.
--- Light wrapper around vim.api.nvim_set_keymap(). Automatically sets silent and noremap to true.
---@param  mode string: character defining the vim mode. empty for all
---@param  lhs string: the key compbination
---@param  rhs string: the action to execute
---@param  opts table: options passed to the function
function M.noremap(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

--- Sets a buffer-local noremap key mapping
--- Light wrapper around vim.api.nvim_buf_set_keymap(). Automatically sets silent and noremap to true.
---@param mode string: character defining the vim mode. empty for all
---@param lhs string: the key compbination
---@param rhs string: the action to execute
---@param opts table: options passed to the function
function M.buf_noremap(bufnr, mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end

	vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

return M
