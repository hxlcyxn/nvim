local M = {}

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

---Sets highlight groups
---@param group string the group name
---@param colors table table containing any of `FG`, `BG` or `GUI`
function M.highlight(group, colors)
	local opts = { fg = "NONE", bg = "NONE", gui = "NONE" }
	opts = vim.tbl_extend("force", opts, colors)
	vim.api.nvim_set_hl(0, group, {})
end

function M.highlight_link(to, from)
	if not from then
		from = "NONE"
	end
	vim.api.nvim_set_hl(0, to, { link = from })
end

return M
