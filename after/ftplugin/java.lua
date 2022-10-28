local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/" .. project_name

local config = {
	cmd = { "jdtls", "-data", workspace_dir },
	root_dir = vim.fs.dirname(vim.fs.find({
		".gradlew",
		".git",
		"mvnw",
	}, { upward = true })[1]),
}
require("jdtls").start_or_attach(config)
