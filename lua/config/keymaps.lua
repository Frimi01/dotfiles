-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local keymap = vim.keymap.set

keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Open netrw file explorer" })
keymap("n", "<leader>r", vim.lsp.buf.rename, { desc = "renames stuff with lsp" })
keymap("n", "<C-a>", "ggVG", { desc = "Selects entire document" })
