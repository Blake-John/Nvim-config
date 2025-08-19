require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>e", ":NvimTreeToggle<cr>")
map("n", "<leader>fk", ":Telescope keymaps<cr>")
map("n", "<leader>cd", "<C-w><C-d>", { desc = "line diagnostic" })
map("n", "<leader>ft", ":TodoTelescope<cr>", { desc = "find todos" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
