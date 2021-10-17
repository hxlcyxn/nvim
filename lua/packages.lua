-- https://github.com/wbthomason/packer.nvim/
-- {{{
local install_path = vim.fn.stdpath("data") .. "/site/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system(
    { "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path }
  )
  vim.api.nvim_exec("packadd packer.nvim", true)
end -- }}}

vim.api.nvim_exec([[packadd packer.nvim]], true) -- {{{
return require("packer").startup {
  function(use)
    -- generic stuff {{{
    use { "wbthomason/packer.nvim" }

    use { "lewis6991/impatient.nvim" }
    -- }}}
    -- lsp etc {{{
    use { "neovim/nvim-lspconfig", config = [[require("plugins.lspconfig")]] }
    use { "onsails/lspkind-nvim" }
    use { "ray-x/lsp_signature.nvim" }
    use { "folke/trouble.nvim", requires = { "kyazdani42/nvim-web-devicons" } }
    use { "simrat39/symbols-outline.nvim" }
    use {
      "kosayoda/nvim-lightbulb",
      config = [[vim.cmd "autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()"]],
    }

    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-emoji",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-path",
        "kdheepak/cmp-latex-symbols",
        "saadparwaiz1/cmp_luasnip",
      },
      config = [[require("plugins.cmp")]],
    }
    use { "L3MON4D3/LuaSnip", config = [[require("plugins.luasnip")]] }
    use { "rafamadriz/friendly-snippets" }

    use {
      "mfussenegger/nvim-dap",
      requires = { "rcarriga/nvim-dap-ui" },
      config = [[require("plugins.dap")]],
    }

    use {
      "simrat39/rust-tools.nvim",
      ft = "rust",
      config = [[require("plugins.rusttools")]],
    }

    use {
      "mhartington/formatter.nvim",
      cmd = { "Format", "FormatWrite" },
      config = [[require("plugins.formatter")]],
    }
    use { 'mfussenegger/nvim-lint', config = [[require("plugins.lint")]] }
    -- }}}

    -- language plugins {{{
    use { "LnL7/vim-nix", ft = "nix" }
    use {
      "iamcco/markdown-preview.nvim",
      run = ":call mkdp#util#install()",
      ft = "markdown",
    }
    use { "plasticboy/vim-markdown", ft = "markdown" }
    use { "rust-lang/rust.vim", ft = "rust" }
    use { "olical/fennel.vim", ft = "fennel" }
    use { "pprovost/vim-ps1", ft = { "Powershell", "ps1" } }
    use { "neovimhaskell/haskell-vim", ft = "haskell" }
    use { "elkowar/yuck.vim", ft = "yuck" }
    -- }}}

    -- quality of life {{{
    use { "https://github.com/jbyuki/venn.nvim" }
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "kyazdani42/nvim-web-devicons",
      },
      config = [[require("plugins.telescope")]],
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = [[require("plugins.treesitter")]],
    }
    use {
      "nvim-treesitter/playground",
      cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
      config = [[require("plugins.treesitter").playground()]],
    }
    use {
      "windwp/nvim-ts-autotag",
      config = [[require("plugins.treesitter").autotag()]],
    }
    use {
      "p00f/nvim-ts-rainbow",
      config = [[require("plugins.treesitter").rainbow()]],
    }
    use {
      "eraserhd/parinfer-rust",
      run = "cargo build --release",
      ft = { "fennel", "lisp", "yuck" },
    }
    use { "windwp/nvim-autopairs", config = [[require("plugins.autopairs")]] }
    use { "editorconfig/editorconfig-vim" }
    use { "godlygeek/tabular", cmd = { "Tab", "Tabularize" } }
    use { "folke/which-key.nvim", config = [[require("keys")]] }
    use { "tpope/vim-surround" }
    use {
      "lewis6991/gitsigns.nvim",
      requires = { "nvim-lua/plenary.nvim" },
      config = [[require("gitsigns").setup { numhl = true }]],
    }
    use { "tpope/vim-repeat" }
    use {
      "timakro/vim-yadi",
      config = [[vim.api.nvim_exec("autocmd BufRead * DetectIndent", true)]],
    }
    use { "b3nj5m1n/kommentary", config = [[require("plugins.kommentary")]] }
    use { "sindrets/diffview.nvim", config = [[require("diffview").setup {}]] }
    use {
      "TimUntersberger/neogit",
      requires = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim" },
      cmd = "Neogit",
      config = [[require("neogit").setup { integrations = { diffview = true } }]],
    }
    use {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeRefresh", "NvimTreeFindFile" },
      requires = { "kyazdani42/nvim-web-devicons" },
      config = [[require("plugins.nvimtree")]],
    }
    use {
      "folke/zen-mode.nvim",
      cmd = "ZenMode",
      wants = "twilight.nvim",
      config = [[require("zen-mode").setup {}]],
    }
    use {
      "folke/twilight.nvim",
      cmd = { "Twilight", "TwilightEnable" },
      config = [[require("twilight").setup {}]],
    }
    -- }}}

    -- stylish {{{
    use { "glepnir/dashboard-nvim", config = [[require("plugins.dashboard")]] }
    use {
      'famiu/feline.nvim',
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
      config = [[require("plugins.feline")]],
    }
    use {
      "akinsho/nvim-bufferline.lua",
      requires = { "kyazdani42/nvim-web-devicons" },
      config = [[require("plugins.bufferline")]],
    }
    use {
      "lukas-reineke/indent-blankline.nvim",
      config = [[require("plugins.indentblankline")]],
    }
    use {
      "norcalli/nvim-colorizer.lua",
      config = [[require("colorizer").setup { "*", "!packer" }]],
    }

    use {
      "Shatur/neovim-ayu",
      config = string.format(
        [[require("ayu").setup {mirage = %s }]], _G.Settings.ayu_mirage
      ) .. " " .. [[require("ayu").colorscheme()]],
    }

    local other_themes = { xresources = "nekonako/xresources-nvim" }
    for name, theme in pairs(other_themes) do
      if _G.Settings.colorscheme == name then
        use { theme, config = [[:colorscheme]] .. name }
      else
        use { theme }
      end
    end
    -- }}}
  end,
  config = {
    -- profile = { enable = true },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
  },
}
-- }}}
