-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- use `vim.keymap.set` instead
local ks = vim.keymap.set

ks("n", "<leader>/", "<Plug>(comment_toggle_linewise_current)", { desc = "toggle comment" })
ks("v", "<leader>/", "<Plug>(comment_toggle_linewise_visual)", { desc = "toggle comment" })

local wk = require("which-key")

wk.add({
  { "<leader>a", group = "avante" },
}, {})
