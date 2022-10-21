local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/" .. project_name

local config = {
	cmd = { "jdtls", "--jvm-arg=-Dlog.level=ALL", "-data", workspace_dir},
	-- cmd = {
	-- 	"java",

	-- 	"-Declipse.application=org.eclipse.jdt.ls.core.id1",
	-- 	"-Dosgi.bundles.defaultStartLevel=4",
	-- 	"-Declipse.product=org.eclipse.jdt.ls.core.product",
	-- 	"-Dlog.protocol=true",
	-- 	"-Dlog.level=ALL",
	-- 	"-Xms1g",
	-- 	"--add-modules=ALL-SYSTEM",
	-- 	"--add-opens",
	-- 	"java.base/java.util=ALL-UNNAMED",
	-- 	"--add-opens",
	-- 	"java.base/java.lang=ALL-UNNAMED",

	-- 	"-jar",
	-- 	"/usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar",

	-- 	"-configuration",
	-- 	"/usr/share/java/jdtls/config_linux",
	-- 	"-data",
	-- 	workspace_dir,
	-- },

	settings = {
		java = {},
	},

	init_options = {
		bundles = {},
	},
}
require("jdtls").start_or_attach(config)
