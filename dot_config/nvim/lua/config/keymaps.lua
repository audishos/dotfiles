local Zk = require("zk.commands")
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Kitty Navigate Splits
vim.keymap.set("n", "<C-j>", "<cmd>KittyNavigateDown<cr>")
vim.keymap.set("n", "<C-k>", "<cmd>KittyNavigateUp<cr>")
vim.keymap.set("n", "<C-l>", "<cmd>KittyNavigateRight<cr>")
vim.keymap.set("n", "<C-h>", "<cmd>KittyNavigateLeft<cr>")

-- ZK
vim.keymap.set("n", "<leader>z", "", { desc = "Zk" })
vim.keymap.set("n", "<leader>zj", function()
  Zk.get("ZkNew")({ group = "daily", dir = "journal/daily" })
end, { desc = "New journal entry" })
