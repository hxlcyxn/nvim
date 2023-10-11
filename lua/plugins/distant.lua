return {
	"chipsenkbeil/distant.nvim",
	branch = "v0.3",
	cmd = { "Distant", "DistantLaunch", "DistantOpen" },
	config = function()
		require("distant"):setup()
	end,
}
