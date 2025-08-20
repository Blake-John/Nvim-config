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

map("n", "<leader>cr", function()
  require "nvchad.lsp.renamer"()
end, { desc = "rename symbol" })

-- NOTE: finder
map("n", "<leader>fk", ":lua Snacks.picker.keymaps()<cr>", { desc = "find keymaps" })
map("n", "<leader>ft", ":TodoTelescope<cr>", { desc = "find todos" })
map("n", "<leader>fd", ":lua Snacks.picker.diagnostics_buffer()<cr>", { desc = "find buffer diagnostics" })
map("n", "<leader>fD", ":lua Snacks.picker.diagnostics()<cr>", { desc = "find diagnostics" })
map("n", "<leader>fm", ":Telescope marks<cr>", { desc = "find marks" })
map("n", "<leader>fs", ":lua Snacks.picker.lsp_symbols()<cr>", { desc = "find buffer symbols" })
map("n", "<leader>fr", ":lua Snacks.picker.lsp_references()<cr>", { desc = "find buffer symbols" })
map("n", "<leader>fw", ":lua Snacks.picker.grep_buffers()<cr>", { desc = "grep in buffer" })
map("n", "<leader>fW", ":lua Snacks.picker.grep()<cr>", { desc = "grep" })
map("n", "<leader>fp", ":lua Snacks.picker.projects()<cr>")

-- map("n", "gR", ":lua Snacks.picker.lsp_references()<cr>", { desc = "find buffer symbols" })

-- NOTE: git
map("n", "<leader>gl", ":lua Snacks.lazygit()<cr>", { desc = "lazygit" })
map("n", "<leader>gc", ":Telescope git_bcommits<cr>", { desc = "find branch commit" })
map("n", "<leader>gb", ":Telescope git_branches<cr>", { desc = "find branch" })
map("n", "<leader>gs", ":Telescope git_stash<cr>", { desc = "find stash" })

-- NOTE: terminal
map({"n", "t"}, "<C-`>", function()
  require("nvchad.term").toggle { pos = "sp", id = "htoggleTerm" }
end, { desc = "toggle terminal bottom" })

map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

require("which-key").add({
  { "<leader>a", group = "avante" },
  { "<leader>c", group = "code" },
  { "<leader>f", group = "find" },
  { "<leader>g", group = "git" },
}, {})
