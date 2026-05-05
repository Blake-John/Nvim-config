vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- better movement in wrapped text
map("n", "j", function()
	return vim.v.count == 0 and "gj" or "j"
end, { expr = true, silent = true, desc = "Down (wrap-aware)" })
map("n", "k", function()
	return vim.v.count == 0 and "gk" or "k"
end, { expr = true, silent = true, desc = "Up (wrap-aware)" })

map("n", "n", "nzzzv", { desc = "Next search centered" })
map("n", "N", "Nzzzv", { desc = "Previous search centered" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Previous search centered" })

map("n", "<leader>bn", ":bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", ":bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bd", ":bprevious<cr>", { desc = "Delete buffer" })
map("n", "<S-h>", ":bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<S-l>", ":bnext<cr>", { desc = "Next Buffer" })
map("n", "[b>", ":bprevious<cr>", { desc = "Prev Buffer" })
map("n", "]b", ":bnext<cr>", { desc = "Next Buffer" })

map("n", "<C-j>", "<C-w>j", { desc = "Move to bottom window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to top window" })
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

map("n", "<leader>wv", ":vsplit<cr>", { desc = "Split window vertically" })
map("n", "<leader>ws", ":split<cr>", { desc = "Split window horizontally" })
map("n", "<leader>wq", "<C-w>q", { desc = "Quit current window" })
map("n", "<leader>w=", "<C-w>=", { desc = "Make split window equal size" })
map("n", "<leader>w+", "<C-w>+", { desc = "increase window height" })
map("n", "<leader>w-", "<C-w>-", { desc = "decrease window height" })
map("n", "<leader>w<", "<C-w><", { desc = "increase window width" })
map("n", "<leader>w>", "<C-w>>", { desc = "decrease window width" })
map("n", "<leader>w|", "<C-w>|", { desc = "max out the width" })
map("n", "<leader>w_", "<C-w>_", { desc = "max out the height" })
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

map("n", "<leader>td", function()
	vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, { desc = "Toggle diagnostics" })
map("n", "<leader>ti", function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, { desc = "Toggle inlay hint" })
map("n", "<leader>cd", function()
	vim.diagnostic.open_float()
end, { desc = "Show Line Diagnostic" })
map("n", "<leader>ca", function()
	vim.lsp.buf.code_action()
end, { desc = "Show Line Diagnostic" })
map("i", "<C-k>", function()
	vim.lsp.buf.signature_help()
end, { desc = "Show Signature" })
map("n", "gd", vim.lsp.buf.definition, { desc = "go to definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "go to declaration" })
map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "rename symbol" })

map({ "n", "i" }, "<C-s>", "<esc>:w<cr>", { desc = "Save file" })
map({ "n", "i" }, "<C-q>", "<esc>:qa<cr>", { desc = "Quit Nvim" })

map("n", "<esc>", ":nohlsearch<cr>")
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace curosr word" })

map("n", "yp", function()
	local filepath = vim.fn.expand("%:~")
	vim.fn.setreg("+", filepath)
	print("file path copied to clipboard: " .. filepath)
end, { desc = "Copy file path" })

-- local function show_plugins()
--     for _, p in ipairs(vim.api.nvim_list_runtime_paths()) do if p:find("/pack/") then print(p) end end
-- end

map(
	"n",
	"<leader>l",
	[[:lua count = 1; for _, p in ipairs(vim.api.nvim_list_runtime_paths()) do if p:find("/pack/") then print(p) count = count + 1 end end print("total plugins: " .. count)<cr>]],
	{ desc = "List Plugins" }
)
-- 智能单步跳出：一次只跳一个结束符，支持多行、引号、括号
local function jump_next_char()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]
	local next_char = line:sub(col + 1, col + 1)

	-- 只跳：) ] } ' " 这几个结束符
	-- 一次只跳一格！绝对不会多跳
	if next_char ~= "" and next_char:match("[%)%]%}`\"',]") then
		return "<Right>"
	end

	-- 不是结束符 → 正常 Tab
	return "<Tab>"
end

map("i", "<Tab>", jump_next_char, { expr = true, silent = true, desc = "Smart jump out of pairs (one by one)" })

-- 回车自动缩进配对：{} () [] "" ''
vim.keymap.set("i", "<cr>", function()
	local line = vim.api.nvim_get_current_line()
	local col = vim.api.nvim_win_get_cursor(0)[2]

	local left = line:sub(col, col)
	local right = line:sub(col + 1, col + 1)
	local left2 = line:sub(col - 1, col)
	local right2 = line:sub(col + 1, col + 2)

	-- 匹配光标在配对中间： {|}, (|), [|], "|", '|'
	local pairs_ = {
		["{}"] = true,
		["()"] = true,
		["[]"] = true,
		["{ }"] = true,
		["( )"] = true,
		["[ ]"] = true,
		["{  }"] = true,
		["(  )"] = true,
		["[  ]"] = true,
		['""'] = true,
		["''"] = true,
	}
	print(left .. right)
	print(left2 .. right2)

	if pairs_[left .. right] or pairs_[left2 .. right2] then
		-- 回车 + 缩进 + 新行 + 上移右括号
		return "<esc>a<cr><esc>ko"
	end

	-- 普通情况直接回车
	return "<cr>"
end, { desc = "enter", expr = true, noremap = true })
