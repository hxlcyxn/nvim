local M = {}

function M.cmd(c)
	return "<cmd>" .. c .. "<cr>"
end

function M.wrapsetup(name)
	return function(_, opts)
		require(name).setup(opts)
	end
end

return M
