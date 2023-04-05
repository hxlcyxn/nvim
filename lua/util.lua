local M = {}

--- Returns the specified command as a formatted cmd-mapping.
---@param c string
---@return string
function M.cmd(c)
	return "<cmd>" .. c .. "<cr>"
end

--- Wraps the setup() call for the supplied function.
---@param name string
---@return function
function M.wrapsetup(name)
	return function(_, opts)
		require(name).setup(opts)
	end
end

return M
