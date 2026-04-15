-- add plugins
vim.pack.add({
	-- "https://github.com/nvim-tree/nvim-tree.lua",
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/echasnovski/mini.nvim",
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/folke/which-key.nvim",
	-- "https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/folke/flash.nvim",
})

local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-- plugin configuration

-- ============================================================
-- nvim-tree - a file tree plugin
-- ============================================================
-- vim.cmd.packadd("nvim-tree.lua")
-- require("nvim-tree").setup({
--     diagnostics = {
--         enable = true,
--     },
--     actions = {
--         open_file = {
--             quit_on_open = true,
--         },
--     },
-- })
-- map("n", "<leader>e", function()
--     require("nvim-tree.api").tree.toggle()
-- end, { desc = "Toggle NvimTree" })

-- ============================================================
-- fzf-lua - a fuzzy finder to find any you want
-- ============================================================
vim.cmd.packadd("fzf-lua")
require("fzf-lua").setup({
	defaults = {
		file_icons = "mini",
	},
})
vim.cmd("FzfLua register_ui_select")
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
map("n", "<leader>fw", function()
	require("fzf-lua").grep_cword()
end, { desc = "Find Current Word" })
map("n", "<leader>fa", function()
	require("fzf-lua").lsp_code_actions()
end, { desc = "Code Action" })
map("n", "<leader>ca", function()
	require("fzf-lua").lsp_code_actions()
end, { desc = "Code Action" })
map("n", "<leader>fr", function()
	require("fzf-lua").lsp_references()
end, { desc = "Find References" })
map("n", "<leader>fs", function()
	require("fzf-lua").lsp_document_symbols()
end, { desc = "Find Symbols" })
map("n", "<leader>fS", function()
	require("fzf-lua").lsp_workspace_symbols()
end, { desc = "Find Workspace Symbols" })
map("n", "<leader>fl", function()
	require("fzf-lua").lsp_finder()
end, { desc = "Lsp Finder" })
map("n", "<leader>fu", function()
	require("fzf-lua").undotree()
end, { desc = "Undotree" })
map("n", "<leader>fk", function()
	require("fzf-lua").keymaps()
end, { desc = "Find Keymaps" })

-- ============================================================
-- mini.nvim - basic function improvement
-- ============================================================
vim.cmd.packadd("mini.nvim")

require("mini.ai").setup() -- object selector for a and i

require("mini.comment").setup() -- toggle comment
map("n", "<C-/>", "gcc", { desc = "Toggle Comment", remap = true })
map("v", "<C-/>", "gcgv", { desc = "Toggle Comment", remap = true })

require("mini.move").setup() -- move line/selected up, down, right, left by alt

require("mini.surround").setup({ -- surround target with char, behave as vim-surround
	mappings = {
		add = "ys", -- Add surrounding in Normal and Visual modes
		delete = "ds", -- Delete surrounding
		find = "ysf", -- Find surrounding (to the right)
		find_left = "ysF", -- Find surrounding (to the left)
		highlight = "ysh", -- Highlight surrounding
		replace = "cs", -- Replace surrounding

		suffix_last = "l", -- Suffix to search with "prev" method
		suffix_next = "n", -- Suffix to search with "next" method
	},
})
vim.keymap.del("x", "ys")
map("x", "S", ":<C-u>lua MiniSurround.add('visual')<CR>", { silent = true })
map("n", "yss", "ys_", { remap = true, silent = true })

require("mini.cursorword").setup() -- highlight word under cursor
require("mini.indentscope").setup() -- show indent
require("mini.pairs").setup() -- auto pair
require("mini.trailspace").setup() -- show space end of line
require("mini.notify").setup() -- float the notifications
require("mini.files").setup() -- file system - edit as a file, press = to syncchronize changes, g? for help
vim.keymap.set("n", "<leader>e", function()
	if vim.bo.filetype == "minifiles" then
		require("mini.files").close()
	else
		require("mini.files").open(vim.api.nvim_buf_get_name(0))
	end
end, { desc = "Toggle mini.files" })
vim.keymap.set("n", "<esc>", function()
	if vim.bo.filetype == "minifiles" then
		require("mini.files").close()
	end
end, { desc = "Close mini.files" })

-- require("mini.statusline").setup()

require("mini.splitjoin").setup({
	mappings = {
		toggle = "gs",
	},
})
map("n", "<leader>ts", ":lua MiniSplitjoin.toggle()<cr>", { desc = "Toggle Params Split" })

-- ==============================================================
-- gitsigns - show the git status
-- ==============================================================
autocmd("BufReadPre", {
	once = true,
	callback = function()
		vim.cmd.packadd("gitsigns.nvim")
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
	end,
})

-- ===============================================================
-- which-key - show key hint
-- ===============================================================
vim.cmd.packadd("which-key.nvim")
require("which-key").setup({
	preset = "modern",
})
require("which-key").add({
	{ "<leader>c", group = "code" },
	{ "<leader>t", group = "toggle" },
	{ "<leader>w", group = "window" },
	{ "<leader>f", group = "Fuzzy Find" },
	{ "<leader>g", group = "Git" },
	{ "<leader>b", group = "Buffer" },
})

-- ===============================================================
-- nvim-web-devicons - add icons for plugin
-- ===============================================================
-- vim.cmd.packadd("nvim-web-devicons")
-- require("nvim-web-devicons").setup()

-- ===============================================================
-- nvim.undotree - manage undo
-- ===============================================================
-- autocmd("BufReadPre", {
-- 	once = true,
-- 	callback = function()
-- 		vim.cmd.packadd("nvim.undotree")
-- 		map("n", "<leader>u", ":Undotree<cr>", { desc = "Toggle Undotree" })
-- 	end,
-- })

-- ===============================================================
-- flash.nvim - easily jump and find
-- ===============================================================
autocmd("BufReadPre", {
	once = true,
	callback = function()
		vim.cmd.packadd("flash.nvim")
		require("flash").setup()
		map({ "n", "x", "o" }, "s", function()
			require("flash").jump()
		end, { desc = "Flash" })
	end,
})
