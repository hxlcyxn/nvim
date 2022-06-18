-- https://github.com/wbthomason/packer.nvim/
-- {{{
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end -- }}}

local config = {
	autoremove = true,
	profile = { enable = true },
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
}

vim.api.nvim_exec([[packadd packer.nvim]], true) -- {{{
return require("packer").startup({
	function(use)
		-- generic stuff {{{
		use({ "wbthomason/packer.nvim" })

		use({ "lewis6991/impatient.nvim" })
		use({ "antoinemadec/FixCursorHold.nvim" })
		-- }}}
		-- lsp etc {{{
		use({ "neovim/nvim-lspconfig", config = [[require("plugins.lspconfig")]] })
		use({ "onsails/lspkind-nvim" })
		use({ "ray-x/lsp_signature.nvim" })
		use({ "folke/trouble.nvim", requires = { "kyazdani42/nvim-web-devicons" } })
		-- use({ "simrat39/symbols-outline.nvim" })
		use({
			"kosayoda/nvim-lightbulb",
			config = [[require("plugins.lightbulb")]],
		})

		use({
			"hrsh7th/nvim-cmp",
			config = [[require("plugins.cmp")]],
		})
		use({ "hrsh7th/cmp-buffer" })
		use({ "hrsh7th/cmp-cmdline" })
		use({ "hrsh7th/cmp-emoji" })
		use({ "hrsh7th/cmp-nvim-lsp" })
		use({ "hrsh7th/cmp-nvim-lua" })
		use({ "hrsh7th/cmp-path" })
		use({ "kdheepak/cmp-latex-symbols" })
		use({ "lukas-reineke/cmp-under-comparator" })
		use({ "saadparwaiz1/cmp_luasnip" })
		use({ "L3MON4D3/LuaSnip", config = [[require("plugins.luasnip")]] })
		use({ "rafamadriz/friendly-snippets" })

		-- use({ "github/copilot.vim" })
		use({
			"zbirenbaum/copilot.lua",
			event = "VimEnter",
			config = [[require("plugins.copilot-lua")]],
		})
		use({ "zbirenbaum/copilot-cmp", module = "copilot_cmp", after = { "nvim-cmp", "copilot.lua" } })

		use({
			"mfussenegger/nvim-dap",
			keys = "<leader>d",
			config = [[require("plugins.dap")]],
		})
		use({
			"rcarriga/nvim-dap-ui",
			after = "nvim-dap",
			keys = "<leader>d",
			config = [[require("plugins.dap").dapui()]],
		})

		use({
			"mhartington/formatter.nvim",
			cmd = { "Format", "FormatWrite" },
			config = [[require("plugins.formatter")]],
		})

		use({ "mfussenegger/nvim-lint", config = [[require("plugins.lint")]] })

		use({
			"Olical/conjure",
			ft = { "fennel", "clojure", "lisp" },
			config = [[vim.g["conjure#extract#tree_sitter#enabled"] = true]],
		})
		-- }}}

		-- language plugins {{{
		use({ "spywhere/detect-language.nvim", config = [[require("detect-language").setup()]] })

		use({ "LnL7/vim-nix", ft = "nix" })

		-- use({ "preservim/vim-markdown", ft = "markdown" })
		use({ "iamcco/markdown-preview.nvim", run = ":call mkdp#util#install()", ft = "markdown" })
		use({ "lukas-reineke/headlines.nvim", ft = "markdown", config = [[require("headlines").setup()]] })
		use({ "ellisonleao/glow.nvim", ft = "markdown" })

		use({ "rust-lang/rust.vim", ft = "rust" })
		use({ "simrat39/rust-tools.nvim", ft = "rust", config = [[require("plugins.rusttools")]] })
		use({
			"Saecki/crates.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			event = "BufRead Cargo.toml",
			config = [[require("crates").setup()]],
		})

		use({ "jaawerth/fennel.vim", ft = "fennel" })

		use({ "pprovost/vim-ps1", ft = { "Powershell", "ps1" } })

		use({ "neovimhaskell/haskell-vim", ft = "haskell" })

		use({ "elkowar/yuck.vim", ft = "yuck" })

		use({ "b0o/schemastore.nvim" })
		-- }}}

		-- *quality of life {{{
		use({ "ahmedkhalf/project.nvim", config = [[require("plugins.project")]] })

		use({ "jghauser/mkdir.nvim" })

		use({ "jbyuki/venn.nvim" })

		use({
			"nvim-telescope/telescope.nvim",
			requires = {
				"nvim-lua/popup.nvim",
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				"nvim-telescope/telescope-ui-select.nvim",
			},
			config = [[require("plugins.telescope")]],
		})

		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = [[require("plugins.treesitter")]] })
		use({
			"nvim-treesitter/playground",
			cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
			config = [[require("plugins.treesitter").playground()]],
		})
		use({ "windwp/nvim-ts-autotag", config = [[require("plugins.treesitter").autotag()]] })
		use({ "p00f/nvim-ts-rainbow", config = [[require("plugins.treesitter").rainbow()]] })
		use({ "lewis6991/nvim-treesitter-context", config = [[require("plugins.treesitter").context()]] })
		use({
			"JoosepAlviste/nvim-ts-context-commentstring",
			config = [[require("plugins.treesitter").commentstring()]],
		})

		use({
			"eraserhd/parinfer-rust",
			run = "cargo build --release",
			ft = { "fennel", "lisp", "yuck" },
		})

		use({ "windwp/nvim-autopairs", after = "nvim-cmp", config = [[require("plugins.autopairs")]] })
		use({ "gpanders/editorconfig.nvim" })
		use({ "godlygeek/tabular", cmd = { "Tab", "Tabularize" } })
		use({ "folke/which-key.nvim", config = [[require("keys")]] })
		use({ "tpope/vim-surround" })

		use({
			"lewis6991/gitsigns.nvim",
			requires = { "nvim-lua/plenary.nvim" },
			config = [[require("gitsigns").setup { numhl = true }]],
		})
		use({ "f-person/git-blame.nvim", setup = [[vim.g.gitblame_enabled = 0]] })
		use({ "sindrets/diffview.nvim", config = [[require("diffview").setup()]] })
		use({
			"TimUntersberger/neogit",
			requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
			cmd = "Neogit",
			config = [[require("neogit").setup { integrations = { diffview = true } }]],
		})

		use({ "tpope/vim-repeat" })

		use({ "timakro/vim-yadi", config = [[require("plugins.yadi")]] })

		-- use({ "ggandor/lightspeed.nvim" })
		use({ "ggandor/leap.nvim", config = [[require("plugins.leap")]] })

		use({ "b3nj5m1n/kommentary", config = [[require("plugins.kommentary")]] })

		use({
			"kyazdani42/nvim-tree.lua",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = [[require("plugins.nvimtree")]],
		})

		use({
			"folke/zen-mode.nvim",
			cmd = "ZenMode",
			wants = "twilight.nvim",
			config = [[require("zen-mode").setup {}]],
		})
		use({
			"folke/twilight.nvim",
			cmd = { "Twilight", "TwilightEnable" },
			config = [[require("twilight").setup {}]],
		})
		-- }}}

		-- stylish {{{
		use({ "rcarriga/nvim-notify", config = [[require("plugins.notify")]] })

		use({ "j-hui/fidget.nvim", config = [[require("fidget").setup()]] })

		use({
			"goolord/alpha-nvim",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = [[require("plugins.alpha")]],
		})

		use({
			"famiu/feline.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
			config = [[require("plugins.feline")]],
		})

		use({
			"akinsho/nvim-bufferline.lua",
			requires = { "kyazdani42/nvim-web-devicons" },
			config = [[require("plugins.bufferline")]],
		})

		use({ "lukas-reineke/indent-blankline.nvim", config = [[require("plugins.indentblankline")]] })
		use({
			"norcalli/nvim-colorizer.lua",
			config = [[require("colorizer").setup { "*", "!packer" }]],
		})

		use({ "rktjmp/lush.nvim" })

		use({
			"Shatur/neovim-ayu",
			config = function()
				require("ayu").setup({
					mirage = _G.Settings.ayu_mirage,
				})
				require("ayu").colorscheme()
			end,
		})

		local other_themes = { xresources = "nekonako/xresources-nvim" }
		for name, theme in pairs(other_themes) do
			if _G.Settings.colorscheme == name then
				use({ theme, config = [[:colorscheme]] .. name })
			else
				use({ theme })
			end
		end
		-- }}}

		if PACKER_BOOTSTRAP then
			require("packer").sync()
		end
	end,
	config = config,
})
-- }}}
