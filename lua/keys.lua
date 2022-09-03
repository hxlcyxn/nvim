local h = require("helpful")
local wk = require("which-key")

local function cmd(c)
	return "<cmd>" .. c .. "<cr>"
end

local function show_documentation()
	local contains = vim.tbl_contains
	local ft = vim.bo.filetype
	local cword = vim.fn.expand("<cword>")
	local filename = vim.fn.expand("%:t")
	if contains({ "vim", "help" }, ft) then
		vim.cmd("h " .. cword)
	elseif contains({ "man" }, ft) then
		vim.cmd("Man " .. cword)
	elseif filename == "Cargo.toml" then
		require("crates").show_popup()
	else
		vim.lsp.buf.hover()
	end
end

wk.setup({
	plugins = { spelling = { enabled = true } },
	window = { border = "single" },
})

wk.register({
	s = { cmd("update"), "save file" },
	q = { cmd("quit"), "quit neovim" },
	b = {
		name = "buffers",
		h = { cmd("bprevious"), "previous buffer" },
		l = { cmd("bnext"), "next buffer" },
		w = { cmd("bwipeout"), "wipeout open buffer" },
		f = { cmd("Telescope buffers show_all_buffers=true"), "open buffer browser" },
	},
	m = {
		name = "code/lsp actions",
		a = { require("neogen").generate, "generate documentation" },
		c = { vim.lsp.buf.code_action, "code actions" },
		h = { show_documentation, "show documentation" },
		r = { cmd("Trouble lsp_references"), "show references" },
		R = { vim.lsp.buf.rename, "rename" },
		s = { vim.lsp.buf.signature_help, "signature help" },
		e = { cmd("Trouble document_diagnostics"), "list diagnostics" },
		E = { cmd("Trouble workspace_diagnostics"), "show diagnostics" },
		g = { vim.lsp.buf.definition, "go to definition" },
		i = { vim.lsp.buf.implementation, "show implementation" },
		F = { vim.lsp.buf.format, "format file with lsp formatter" },
	},
	d = {
		name = "debugging",
		b = {
			function()
				require("dap").toggle_breakpoint()
			end,
			"toggle breakpoint",
		},
		u = {
			function()
				require("dapui").toggle()
			end,
			"toggle dapui",
		},
		c = {
			function()
				require("dap").continue()
			end,
			"continue",
		},
	},
	f = {
		name = "files",
		a = { cmd("Telescope live_grep"), "grep files" },
		f = { cmd("Telescope find_files"), "open file finder" },
		h = { cmd("Telescope oldfiles"), "open file hsitory" },
		n = { cmd("enew"), "create new file" },
		s = { cmd("Telescope projects"), "select & open projects" },
	},
	g = { name = "git", b = { cmd("GitBlameToggle"), "toggle blame" }, g = { cmd("Neogit"), "neogit" } },
	p = {
		name = "packer",
		s = { require("packer").sync, "sync plugins" },
		S = { require("packer").status, "packer status" },
	},
}, {
	prefix = "<leader>",
})

h.noremap("t", "<Esc>", "<C-\\><C-n>")

h.noremap("n", "<M-F>", ":Format<CR>", { silent = false })
