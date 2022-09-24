local helpful = require("helpful")

local headers = {
	ayaya = {
		"⡿⠋⠄⣀⣀⣤⣴⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⣌⠻⣿⣿",
		"⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⠹⣿",
		"⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠹",
		"⣿⣿⡟⢹⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡛⢿⣿⣿⣿⣮⠛⣿⣿⣿⣿⣿⣿⡆",
		"⡟⢻⡇⢸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣣⠄⡀⢬⣭⣻⣷⡌⢿⣿⣿⣿⣿⣿",
		"⠃⣸⡀⠈⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⠈⣆⢹⣿⣿⣿⡈⢿⣿⣿⣿⣿",
		"⠄⢻⡇⠄⢛⣛⣻⣿⣿⣿⣿⣿⣿⣿⣿⡆⠹⣿⣆⠸⣆⠙⠛⠛⠃⠘⣿⣿⣿⣿",
		"⠄⠸⣡⠄⡈⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠁⣠⣉⣤⣴⣿⣿⠿⠿⠿⡇⢸⣿⣿⣿",
		"⠄⡄⢿⣆⠰⡘⢿⣿⠿⢛⣉⣥⣴⣶⣿⣿⣿⣿⣻⠟⣉⣤⣶⣶⣾⣿⡄⣿⡿⢸",
		"⠄⢰⠸⣿⠄⢳⣠⣤⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⣼⣿⣿⣿⣿⣿⣿⡇⢻⡇⢸",
		"⢷⡈⢣⣡⣶⠿⠟⠛⠓⣚⣻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣇⢸⠇⠘",
		"⡀⣌⠄⠻⣧⣴⣾⣿⣿⣿⣿⣿⣿⣿⣿⡿⠟⠛⠛⠛⢿⣿⣿⣿⣿⣿⡟⠘⠄⠄",
		"⣷⡘⣷⡀⠘⣿⣿⣿⣿⣿⣿⣿⣿⡋⢀⣠⣤⣶⣶⣾⡆⣿⣿⣿⠟⠁⠄⠄⠄⠄",
		"⣿⣷⡘⣿⡀⢻⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣿⣿⣿⣿⣷⡿⠟⠉⠄⠄⠄⠄⡄⢀",
		"⣿⣿⣷⡈⢷⡀⠙⠛⠻⠿⠿⠿⠿⠿⠷⠾⠿⠟⣛⣋⣥⣶⣄⠄⢀⣄⠹⣦⢹⣿",
	},
	default = {
		" ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗  █████╗ ██████╗ ██████╗  ",
		" ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔══██╗ ",
		" ██║  ██║███████║███████╗███████║██████╔╝██║   ██║███████║██████╔╝██║  ██║ ",
		" ██║  ██║██╔══██║╚════██║██╔══██║██╔══██╗██║   ██║██╔══██║██╔══██╗██║  ██║ ",
		" ██████╔╝██║  ██║███████║██║  ██║██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝ ",
		" ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ",
	},
	neovim = {
		" ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗",
		" ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║",
		" ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║",
		" ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║",
		" ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║",
		" ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝",
	},
}

local default_opts = {
	position = "center",
}

--- @param value string|string[]
--- @param opts? table
--- @return table
local function text(value, opts)
	local config = {
		type = "text",
		val = value,
		opts = default_opts,
	}
	if opts then
		config.opts = vim.tbl_extend("force", config.opts, opts)
	end
	return config
end

--- @param value string
--- @param shortcut string
--- @param opts? table
local function button(value, shortcut, opts)
	local config = {
		type = "button",
		val = value,
		on_press = function()
			local key =
				vim.api.nvim_replace_termcodes(shortcut:gsub("%s", ""):gsub("SPC", "<leader>"), true, false, true)
			vim.api.nvim_feedkeys(key, "normal", false)
		end,
	}
	local options = {
		shortcut = shortcut,
		align_shortcut = "right",
		width = 30,
	}
	options = vim.tbl_extend("force", options, default_opts)
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	config.opts = options
	return config
end

--- @param items table[]
--- @param spacing? number
--- @return table
local function group(items, spacing)
	return {
		type = "group",
		val = items,
		opt = { spacing = spacing or 0 },
	}
end

--- @param size number?
--- @return table
local function padding(size)
	return { type = "padding", val = size or 1 }
end

local header = text(headers.ayaya, { hl = "AlphaHeader" })

local process_handle = io.popen(
	string.format([[fd -d 2 . %s | head -n -2 | wc -l | tr -d "\n"]], vim.fn.stdpath("data") .. "/site/pack/packer")
)
local package_count = process_handle:read("*a")
process_handle:close()

local info = text(("loaded %d plugins."):format(package_count), { hl = "AlphaInfo" })
local shortcuts = group({
	button("find file", "SPC f f", { hl = "AlphaText", hl_shortcut = "AlphaText" }),
	button("new file", "SPC f n", { hl = "AlphaText", hl_shortcut = "AlphaText" }),
	button("search for strings", "SPC f a", { hl = "AlphaText", hl_shortcut = "AlphaText" }),
})
-- local footer = text("")

local config = {
	layout = {
		header,
		padding(),
		info,
		padding(),
		shortcuts,
		-- footer,
	},
	opts = {},
}

helpful.highlight_link("AlphaHeader", "Normal")
helpful.highlight_link("AlphaInfo", "Comment")
helpful.highlight_link("AlphaText", "Normal")

require("alpha").setup(config)
