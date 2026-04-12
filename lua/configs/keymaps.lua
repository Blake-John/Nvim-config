vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- better movement in wrapped text
map("n", "j", function() return vim.v.count == 0 and "gj" or "j" end,
    { expr = true, silent = true, desc = "Down (wrap-aware)" })
map("n", "k", function() return vim.v.count == 0 and "gk" or "k" end,
    { expr = true, silent = true, desc = "Up (wrap-aware)" })

map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Previous search centered" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Previous search centered" })

map("n", "<leader>bn", ":bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<cr>", { desc = "Previous buffer" })
map("n", "<S-h>", ":bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", ":bnext<cr>", { desc = "Next Buffer" })
map("n", "[b>", ":bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", ":bnext<cr>", { desc = "Next Buffer" })

map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

map("n", "<leader>wv", ":vsplit<cr>", { desc = "Split window vertically" })
map("n", "<leader>wv", ":vsplit<cr>", { desc = "Split window vertically" })
map("n", "<leader>we", "<C-w>=", { desc = "Make split window equal size" })
map("n", "<leader>wq", "<C-w>q", { desc = "Quit current window" })
map("n", "<C-up>", ":resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-down>", ":resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-left>", ":vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-right>", ":vertical resize +2<cr>", { desc = "Increase window width" })

-- replaced by mini.move
-- map("n", "<A-j>", ":m .+1<cr>==", { desc = "Move line down" })
-- map("n", "<A-k>", ":m .-2<cr>==", { desc = "Move line up" })
-- map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
-- map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

map("v", ">", ">gv", { desc = "Indent left" })
map("v", "<", "<gv", { desc = "Indent right" })

map("n", "<leader>td", function() vim.diagnostic.enable(not vim.diagnostic.is_enabled()) end,
    { desc = "Toggle diagnostics" })
map("n", "<leader>ti", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end,
    { desc = "Toggle inlay hint" })
map("n", "<leader>cd", function() vim.diagnostic.open_float() end, { desc = "Show Line Diagnostic" })
map("n", "<leader>ca", function() vim.lsp.buf.code_action() end, { desc = "Show Line Diagnostic" })
map("i", "<C-k>", function() vim.lsp.buf.signature_help() end, { desc = "Show Signature" })
map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "go to declaration" })

map({ "n", "i" }, "<C-s>", "<esc>:w<cr>", { desc = "Save file" })

map("n", "<esc>", ":nohl<cr>")
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace curosr word" })

map("n", "yp", function()
    local filepath = vim.fn.expand("%:~")
    vim.fn.setreg("+", filepath)
    print("file path copied to clipboard: " .. filepath)
end, { desc = "Copy file path" })


map("n", "<C-/>", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<C-/>", "gcc", { desc = "Toggle comment", remap = true })

-- Tree-sitter incremental selection
-- local ts_incremental = require('vim.treesitter.incremental')
-- vim.keymap.set('n', '<CR>', function() ts_incremental.node_incremental() end, { desc = "Increase Selection" })
-- vim.keymap.set('n', '<BS>', function() ts_incremental.node_decremental() end, { desc = "Decrease Selection" })
-- vim.keymap.set('v', '<CR>', function() ts_incremental.node_incremental() end, { desc = "Increase Selection" })
-- vim.keymap.set('v', '<BS>', function() ts_incremental.node_decremental() end, { desc = "Decrease Selection" })
