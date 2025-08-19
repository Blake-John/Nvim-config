require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>e", ":NvimTreeToggle<cr>", { desc = "toggle nvimtree" })

-- NOTE: code
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "show line diagnostic" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "show code action" })

map("n", "<leader>cf", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "format buffer" })
map("v", "<leader>cf", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "format selection" })

-- NOTE: telescope finder
map("n", "<leader>fk", ":Telescope keymaps<cr>", { desc = "find keymaps" })
map("n", "<leader>ft", ":TodoTelescope<cr>", { desc = "find todos" })
map("n", "<leader>fd", function()
  require("telescope.builtin").diagnostics { bufnr = 0 }
end, { desc = "find buffer diagnostics" })
map("n", "<leader>fD", ":Telescope diagnostics<cr>", { desc = "find diagnostics" })
map("n", "<leader>fm", ":Telescope marks<cr>", { desc = "find marks" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
