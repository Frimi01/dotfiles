-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

-- Open netrw file explorer with <leader>pv
keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw file explorer" })

keymap("n", "<C-a>", "ggVG", { desc = "Selects entire document" })
