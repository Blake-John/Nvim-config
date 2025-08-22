-- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
local map = vim.keymap.set

-- NOTE: Basic Operation
-- better up/down
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>m +1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m -2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m +1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m -2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move Up" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- move in line
map("n", "gl", "$", { desc = "move to end of line" })
map("n", "gh", "^", { desc = "move to start of line" })
map("i", "<C-h>", "<esc>ha", { desc = "move left" })
map("i", "<C-l>", "<esc>la", { desc = "move right" })
map("i", "<C-j>", "<esc>ja", { desc = "move down" })
map("i", "<C-k>", "<esc>ka", { desc = "move up" })

-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

-- scroll by line
map({ "n", "v", "o" }, "<C-S-k>", "<C-y>", { remap = true, desc = "scroll line up" })
map({ "n", "v", "o" }, "<C-S-j>", "<C-e>", { remap = true, desc = "scroll line down" })
map("i", "<C-S-k>", "<esc><C-y>gi", { remap = true, desc = "scroll line up" })
map("i", "<C-S-j>", "<esc><C-e>gi", { remap = true, desc = "scroll line down" })

-- NOTE: comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })
map("n", "<C-/>", "gcc", { desc = "toggle comment", remap = true })
map("v", "<C-/>", "gc", { desc = "toggle comment", remap = true })
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- NOTE: buffers
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>`", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
map("n", "<leader>bd", function()
	Snacks.bufdelete()
end, { desc = "Delete Buffer" })
map("n", "<leader>bo", function()
	Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
map("n", "<leader>bD", "<cmd>bd<cr>", { desc = "Delete Buffer and Window" })

-- NOTE: code
-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "show line diagnostic" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- action
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "show code action" })

-- format
map("n", "<leader>cf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "format buffer" })
map("v", "<leader>cf", function()
	require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "format selection" })

-- rename
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename symbol" })

-- goto
map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })

-- NOTE: file operations
map("n", "<leader>e", function()
	Snacks.explorer()
end, { desc = "toggle file tree" })
-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- NOTE: finder
--
-- map("n", "<leader>ff", "<cmd>lua Snacks.picker.files()<cr>", { desc = "find files" })
-- map("n", "<leader>fb", "<cmd>lua Snacks.picker.buffers()<cr>", { desc = "find buffers" })
-- map("n", "<leader>fk", "<cmd>lua Snacks.picker.keymaps()<cr>", { desc = "find keymaps" })
-- map("n", "<leader>ft", "<cmd>lua Snacks.picker.todo_comments()<cr>", { desc = "find todos" })
-- map("n", "<leader>fd", "<cmd>lua Snacks.picker.diagnostics_buffer()<cr>", { desc = "find buffer diagnostics" })
-- map("n", "<leader>fD", "<cmd>lua Snacks.picker.diagnostics()<cr>", { desc = "find diagnostics" })
-- map("n", "<leader>fm", "<cmd>lua Snacks.picker.marks()<cr>", { desc = "find marks" })
-- map("n", "<leader>fs", "<cmd>lua Snacks.picker.lsp_symbols()<cr>", { desc = "find buffer symbols" })
-- map("n", "<leader>fr", "<cmd>lua Snacks.picker.lsp_references()<cr>", { desc = "find buffer symbols" })
-- map("n", "<leader>fw", "<cmd>lua Snacks.picker.grep_word()<cr>", { desc = "grep in buffer" })
-- map("n", "<leader>fW", "<cmd>lua Snacks.picker.grep()<cr>", { desc = "grep" })
-- map("n", "<leader>fp", "<cmd>lua Snacks.picker.projects()<cr>", { desc = "find projects" })
-- map("n", "<leader>fn", "<cmd>lua Snacks.picker.notifications()<cr>", { desc = "find notifications" })
-- map("n", "<leader>fh", "<cmd>lua Snacks.picker.help()<cr>", { desc = "find help" })
-- map("n", "<leader>fc", "<cmd>lua Snacks.picker.colorschemes()<cr>", { desc = "find colorscheme" })
map("n", "<leader>ff", "<cmd>FzfLua files<cr>", { desc = "find files" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<cr>", { desc = "find buffers" })
map("n", "<leader>fk", "<cmd>FzfLua keymaps<cr>", { desc = "find keymaps" })
map("n", "<leader>ft", "<cmd>lua Snacks.picker.todo_comments()<cr>", { desc = "find todos" })
map("n", "<leader>fd", "<cmd>FzfLua lsp_document_diagnostics<cr>", { desc = "find buffer diagnostics" })
map("n", "<leader>fD", "<cmd>FzfLua lsp_workspace_diagnostics<cr>", { desc = "find workspace diagnostics" })
map("n", "<leader>fm", "<cmd>FzfLua marks<cr>", { desc = "find marks" })
map("n", "<leader>fs", "<cmd>FzfLua lsp_document_symbols<cr>", { desc = "find buffer symbols" })
map("n", "<leader>fS", "<cmd>FzfLua lsp_workspace_symbols<cr>", { desc = "find workspace symbols" })
map("n", "<leader>fr", "<cmd>FzfLua lsp_references<cr>", { desc = "find references" })
map("n", "<leader>fw", "<cmd>FzfLua grep_curbuf<cr>", { desc = "grep in buffer" })
map("v", "<leader>fw", "<cmd>FzfLua grep_visual<cr>", { desc = "grep selected in buffer" })
map("n", "<leader>fW", "<cmd>FzfLua grep_cword<cr>", { desc = "grep current word" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<cr>", { desc = "live grep in workspace" })
map("n", "<leader>fp", "<cmd>lua Snacks.picker.projects()<cr>", { desc = "find projects" })
map("n", "<leader>fn", "<cmd>lua Snacks.picker.notifications()<cr>", { desc = "find notifications" })
map("n", "<leader>fh", "<cmd>FzfLua helptags<cr>", { desc = "find help" })
map("n", "<leader>fc", "<cmd>lua Snacks.picker.colorschemes()<cr>", { desc = "find colorscheme" })

-- Clear search and stop snippet on escape
map({ "i", "n", "s" }, "<esc>", function()
	vim.cmd("noh")
	-- LazyVim.cmp.actions.snippet_stop()
	return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
map(
	"n",
	"<leader>ur",
	"<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
	{ desc = "Redraw / Clear hlsearch / Diff Update" }
)

-- lazy
map("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
map("n", "<leader>nf", "<cmd>enew<cr>", { desc = "New File" })

-- location list
map("n", "<leader>xl", function()
	local success, err = pcall(vim.fn.getloclist(0, { winid = 0 }).winid ~= 0 and vim.cmd.lclose or vim.cmd.lopen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Location List" })

-- quickfix list
map("n", "<leader>xq", function()
	local success, err = pcall(vim.fn.getqflist({ winid = 0 }).winid ~= 0 and vim.cmd.cclose or vim.cmd.copen)
	if not success and err then
		vim.notify(err, vim.log.levels.ERROR)
	end
end, { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- NOTE: Snacks toggle options
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.diagnostics():map("<leader>ud")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.option("number", { name = "Line Number" }):map("<leader>ul")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle
			.option(
				"conceallevel",
				{ off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" }
			)
			:map("<leader>uc")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle
			.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
			:map("<leader>uA")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.treesitter():map("<leader>uT")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.dim():map("<leader>uD")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.animate():map("<leader>ua")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.indent():map("<leader>ug")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.scroll():map("<leader>uS")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.profiler():map("<leader>dpp")
	end,
})
vim.api.nvim_create_autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		Snacks.toggle.profiler_highlights():map("<leader>dph")
	end,
})

if vim.lsp.inlay_hint then
	vim.api.nvim_create_autocmd("User", {
		pattern = "VeryLazy",
		callback = function()
			Snacks.toggle.inlay_hints():map("<leader>uh")
		end,
	})
end

-- NOTE: git and lazygit
if vim.fn.executable("lazygit") == 1 then
	map("n", "<leader>gg", function()
		Snacks.lazygit()
	end, { desc = "Lazygit" })
end
map("n", "<leader>gB", "<cmd>FzfLua git_blame<cr>", { desc = "find git blame" })
map("n", "<leader>gl", "<cmd>FzfLua git_commits<cr>", { desc = "find branch commit log" })
map("n", "<leader>gb", "<cmd>FzfLua git_branches<cr>", { desc = "find branch" })
map("n", "<leader>gs", "<cmd>FzfLua git_stash<cr>", { desc = "find stash" })
map("n", "<leader>gt", "<cmd>FzfLua git_status<cr>", { desc = "find status" })
map("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<cr>", { desc = "show git hunk" })

map({ "n", "x" }, "<leader>gY", function()
	Snacks.gitbrowse({
		open = function(url)
			vim.fn.setreg("+", url)
		end,
		notify = false,
	})
end, { desc = "copy remote url" })

-- NOTE: inspect highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", function()
	vim.treesitter.inspect_tree()
	vim.api.nvim_input("I")
end, { desc = "Inspect Tree" })

-- NOTE: terminal
-- floating terminal
map({ "n", "t", "i" }, "<C-`>", function()
	Snacks.terminal()
end, { desc = "Terminal (Root Dir)" })

-- Terminal Mappings
map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })

-- NOTE: windows
map("n", "<leader>wh", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- NOTE: which-key group
require("which-key").add({
	{ "<leader>a", group = "avante" },
	{ "<leader>c", group = "code" },
	{ "<leader>f", group = "find" },
	{ "<leader>g", group = "git" },
	{ "<leader>g", group = "buffer" },
	{ "<leader>w", group = "window" },
	{ "<leader>u", group = "ui" },
}, {})
