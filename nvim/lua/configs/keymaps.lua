local map = vim.api.nvim_set_keymap

-- map ( <mode>, <key>, <cmd/reflection>, opts)

-- set the keymaps for the cursor movement
map ("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map ("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map ("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map ("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
map ("n", "j", "gj", { desc = "Down" })
map ("n", "k", "gk", { desc = "Up" })

map ("i", "<C-h>", "<esc><C-w>h", { desc = "Go to left window" })
map ("i", "<C-j>", "<esc><C-w>j", { desc = "Go to lower window" })
map ("i", "<C-k>", "<esc><C-w>k", { desc = "Go to upper window" })
map ("i", "<C-l>", "<esc><C-w>l", { desc = "Go to right window" })

-- set the keymaps for the windows resize
map ("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Increase window height" })
map ("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Decrease window height" })
map ("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Increase window width" })
map ("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Decrease window width" })

-- set the keymaps for the line movement
map ("n", "<A-j>", "<cmd>m .+1<CR>==", { desc = "Move Down" })
map ("n", "<A-k>", "<cmd>m .-2<CR>==", { desc = "Move Up" })
map ("i", "<A-Down>", "<esc><cmd>m .+1<CR>==gi", { desc = "Move Down" })
map ("i", "<A-Up>", "<esc><cmd>m .-2<CR>==gi", { desc = "Move Up" })
map ("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
map ("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move Up" })

-- Clear search with <esc>
map ("n", "<esc>", ":noh<CR>", { desc = "Escape and clear hlsearch" })

-- Add undo break-points
map ("i", ",", ",<c-g>u", {})
map ("i", ".", ".<c-g>u", {})
map ("i", ";", ";<c-g>u", {})
map ("i", ":", ":<c-g>u", {})
map ("i", "\n", "\n<c-g>u", {})
map ("i", "<cr>", "<cr><c-g>u", {})

-- better indenting
map ("v", "<tab>", ">gv", { desc = "Indent Right" })
map ("v", "<S-tab>", "<gv", { desc = "Indent Left" })
-- map ("i", "<tab>", "<esc><S-v>>i", {})
-- map ("i", "<S-tab>", "<esc><S-v><i", {})
map ("n", "<tab>", "<esc><S-v>><esc>", { desc = "Indent Right" })
map ("n", "<S-tab>", "<esc><S-v><<esc>", { desc = "Indent Left" })

-- split the windows
map ("n", "<leader>\\", "<c-w>v", { desc = "Split window Right" })
map ("n", "<leader>-", "<c-w>s", { desc = "Split window Bellow" })
map ("n", "<leader>q", "<c-w>q", {desc = "Quit a window" })

-- the buffer change
map ("n", "<C-]>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map ("n", "<C-[>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map ("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })
map ("n", "<leader>bcr", "<cmd>BufferLineCloseRight<CR>", { desc = "Close Right Buffers" })
map ("n", "<leader>bcl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Close Left Buffers" })
map ("n", "<leader>bco", "<cmd>BufferLineCloseOthers<CR>", { desc = "Close Other Buffers" })


-- terminal
map ("n", "<C-`>", ":sp | terminal<CR>", { desc = "Terminal Bellow"})
map ("n", "<C-/>", ":vsp | terminal<CR>", { desc = "Terminal Right"})
