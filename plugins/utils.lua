-- add plugins
vim.pack.add({
    "https://github.com/nvim-tree/nvim-tree.lua",
    "https://github.com/ibhagwan/fzf-lua",
    "https://github.com/echasnovski/mini.nvim",
    "https://github.com/lewis6991/gitsigns.nvim"
})


local map = vim.keymap.set

vim.cmd.packadd("nvim-tree.lua")
vim.cmd.packadd("fzf-lua")
vim.cmd.packadd("mini.nvim")
vim.cmd.packadd("gitsigns.nvim")

-- plugins setup
-- nvim-tree
require("nvim-tree").setup({
    diagnostics = {
        enable = true,
    },
    actions = {
        open_file = {
            quit_on_open = true,
        }
    }
})
map("n", "<leader>e", function()
    require("nvim-tree.api").tree.toggle()
end, { desc = "Toggle NvimTree" })

-- fzf-lua
require("fzf-lua").setup()

map("n", "<leader>ff", function()
    require("fzf-lua").files()
end, { desc = "Find Files" })
map("n", "<leader>fg", function()
    require("fzf-lua").live_grep()
end, { desc = "Live Grep" })
map("n", "<leader>fb", function()
    require("fzf-lua").buffers()
end, { desc = "Find Buffers" })
map("n", "<leader>fh", function()
    require("fzf-lua").help_tags()
end, { desc = "Find Help" })
map("n", "<leader>fd", function()
    require("fzf-lua").diagnostics_document()
end, { desc = "Find Buffer Diagnostics" })
map("n", "<leader>fD", function()
    require("fzf-lua").diagnostics_workspace()
end, { desc = "Find Workspace Diagnostics" })


-- mini.nvim
require("mini.ai").setup()
require("mini.comment").setup()
map("n", "<C-/>", "gcc", { desc = "Toggle Comment", noremap = true })
require("mini.move").setup()
require("mini.surround").setup({
    mappings = {
        add = 'ys', -- Add surrounding in Normal and Visual modes
        delete = 'ds', -- Delete surrounding
        find = 'ysf', -- Find surrounding (to the right)
        find_left = 'ysF', -- Find surrounding (to the left)
        highlight = 'ysh', -- Highlight surrounding
        replace = 'cs', -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
    },
})
map("x", "S", ":<C-u>lua MiniSurround.add('visual')<CR>", { silent = true })
map("n", "yss", "ys_", { remap = true, silent = true })

require("mini.cursorword").setup()
require("mini.indentscope").setup()
require("mini.pairs").setup()
require("mini.icons").setup()
require("mini.trailspace").setup()
require("mini.notify").setup()


require("gitsigns").setup()
map("n", "]h", function()
    require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })
map("n", "[h", function()
    require("gitsigns").prev_hunk()
end, { desc = "Presious git hunk" })
map("n", "<leader>gh", function()
    require("gitsigns").preview_hunk()
end, { desc = "Preview hunk" })
map("n", "<leader>gb", function()
    require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle line blame" })
map("n", "<leader>gd", function()
    require("gitsigns").diffthis()
end, { desc = "Diff this" })
