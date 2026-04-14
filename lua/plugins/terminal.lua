-- ==============================================
-- 原生浮动终端（Floating Terminal）
-- 无需任何插件，纯 Neovim API 实现
-- 快捷键：<leader>t 切换浮动终端
-- 终端模式下按 <Esc> 关闭终端
-- ==============================================

-- 创建自动命令组
local augroup = vim.api.nvim_create_augroup("FloatingTerminal", { clear = true })

-- 终端关闭时自动删除缓冲区
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		if vim.v.event.status == 0 then
			vim.api.nvim_buf_delete(0, {})
		end
	end,
})

-- 终端打开时隐藏行号和符号列
vim.api.nvim_create_autocmd("TermOpen", {
	group = augroup,
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		vim.opt_local.signcolumn = "no"
	end,
})

-- 全局高亮组设置（只定义一次）
vim.api.nvim_set_hl(0, "FloatingTermNormal", { bg = "none" })
vim.api.nvim_set_hl(0, "FloatingTermBorder", { bg = "none" })

-- 终端状态管理
local terminal_state = { buf = nil, win = nil, is_open = false }

-- 浮动终端核心函数
local function FloatingTerminal()
	-- 如果终端已打开，关闭它
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
		return
	end

	-- 如果缓冲区不存在或已失效，创建新缓冲区
	if not terminal_state.buf or not vim.api.nvim_buf_is_valid(terminal_state.buf) then
		terminal_state.buf = vim.api.nvim_create_buf(false, true)
		vim.bo[terminal_state.buf].bufhidden = "hide"
	end

	-- 计算浮动窗口大小和位置（居中显示）
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- 打开浮动窗口
	terminal_state.win = vim.api.nvim_open_win(terminal_state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded", -- 圆角边框，可选：single/double/shadow
	})

	-- 窗口透明和高亮设置
	vim.wo[terminal_state.win].winblend = 0
	vim.wo[terminal_state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"

	-- 如果缓冲区没有终端，启动系统 shell
	local has_terminal = false
	local lines = vim.api.nvim_buf_get_lines(terminal_state.buf, 0, -1, false)
	for _, line in ipairs(lines) do
		if line ~= "" then
			has_terminal = true
			break
		end
	end

	if not has_terminal then
		vim.fn.termopen(os.getenv("SHELL"))
	end

	-- 标记终端为打开状态，并进入插入模式
	terminal_state.is_open = true
	vim.cmd("startinsert")

	-- 离开终端缓冲区时自动关闭窗口
	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = terminal_state.buf,
		callback = function()
			if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
				vim.api.nvim_win_close(terminal_state.win, false)
				terminal_state.is_open = false
			end
		end,
		once = true,
	})
end

-- 快捷键映射
vim.keymap.set(
	"n",
	"<leader>tt",
	FloatingTerminal,
	{ noremap = true, silent = true, desc = "Toggle floating terminal" }
)

vim.keymap.set("t", "<Esc>", function()
	if terminal_state.is_open and terminal_state.win and vim.api.nvim_win_is_valid(terminal_state.win) then
		vim.api.nvim_win_close(terminal_state.win, false)
		terminal_state.is_open = false
	end
end, { silent = true, desc = "Close floating terminal" })
