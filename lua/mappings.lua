local cmd = require("util").cmd
local map = vim.api.nvim_set_keymap

vim.g.mapleader = Settings.mapleader
vim.g.maplocalleader = Settings.maplocalleader

map("n", "<leader>s", cmd("update"), { desc = "save changes" })
map("n", "<leader>q", cmd("quit"), { desc = "quit nvim" })
map("n", "<leader>bh", cmd("bprevious"), { desc = "previous buffer" })
map("n", "<leader>bl", cmd("bnext"), { desc = "next buffer" })
map("n", "<leader>bw", cmd("bwipeout"), { desc = "wipe current buffer" })

map("t", "<Esc>", "<C-\\><C-n>", {})
