-- ==============================================
-- 原生浮动终端（Floating Terminal）功能
-- 无需任何插件，纯 Neovim API 实现
-- 终端模式下按 <Esc> 关闭终端
-- ==============================================

-- 创建自动命令组
local augroup = vim.api.nvim_create_augroup("FloatingTerminal", { clear = true })

-- 终端状态管理
local utils_state = {
	["bash"] = { buf = nil, win = nil, is_open = false },
	["lazygit"] = { buf = nil, win = nil, is_open = false },
	["yazi"] = { buf = nil, win = nil, is_open = false },
}

-- 终端关闭时自动删除缓冲区
vim.api.nvim_create_autocmd("TermClose", {
	group = augroup,
	callback = function()
		local current_buf = vim.api.nvim_get_current_buf()
		-- 遍历找到对应的终端状态
		for cmd, state in pairs(utils_state) do
			if state.buf == current_buf then
				-- 关闭窗口（如果还存在）
				if state.win and vim.api.nvim_win_is_valid(state.win) then
					vim.api.nvim_win_close(state.win, false)
				end
				-- 重置状态
				state.win = nil
				state.is_open = false
				-- 正常退出时删除缓冲区
				if vim.v.event.status == 0 then
					if vim.api.nvim_buf_is_valid(state.buf) then
						vim.api.nvim_buf_delete(state.buf, { force = true })
					end
					state.buf = nil
				end
				break
			end
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

-- 浮动终端核心函数
local function FloatingTerminal(cmd)
	-- 如果终端已打开，关闭它
	if utils_state[cmd].is_open then
		if utils_state[cmd].win and vim.api.nvim_win_is_valid(utils_state[cmd].win) then
			vim.api.nvim_win_close(utils_state[cmd].win, false)
		end
		utils_state[cmd].win = nil
		utils_state[cmd].is_open = false
		return
	end

	-- 如果缓冲区不存在或已失效，创建新缓冲区
	if not utils_state[cmd].buf or not vim.api.nvim_buf_is_valid(utils_state[cmd].buf) then
		utils_state[cmd].buf = vim.api.nvim_create_buf(false, true)
		vim.bo[utils_state[cmd].buf].bufhidden = "hide"
	end

	-- 计算浮动窗口大小和位置（居中显示）
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	-- 打开浮动窗口
	utils_state[cmd].win = vim.api.nvim_open_win(utils_state[cmd].buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded", -- 圆角边框，可选：single/double/shadow
	})

	-- 窗口透明和高亮设置
	vim.wo[utils_state[cmd].win].winblend = 0
	vim.wo[utils_state[cmd].win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"

	-- 如果缓冲区没有终端，启动系统 shell
	local has_utils = false
	local lines = vim.api.nvim_buf_get_lines(utils_state[cmd].buf, 0, -1, false)
	for _, line in ipairs(lines) do
		if line ~= "" then
			has_utils = true
			break
		end
	end

	if not has_utils then
		vim.fn.termopen(cmd)
	end

	-- 标记终端为打开状态，并进入插入模式
	utils_state[cmd].is_open = true
	vim.cmd("startinsert")

	vim.keymap.set("t", "<Esc>", function()
		for key, _ in pairs(utils_state) do
			if
				utils_state[key].is_open
				and utils_state[key].win
				and vim.api.nvim_win_is_valid(utils_state[key].win)
			then
				vim.api.nvim_win_close(utils_state[key].win, false)
				utils_state[key].is_open = false
			end
			if key == "lazygit" then
				if utils_state[key].buf and vim.api.nvim_buf_is_valid(utils_state[key].buf) then
					vim.api.nvim_buf_delete(utils_state[key].buf, { force = true })
				end
				utils_state[key].win = nil
				utils_state[key].buf = nil
			end
		end
	end, { silent = true, desc = "Close floating terminal" })

	-- 离开终端缓冲区时自动关闭窗口
	vim.api.nvim_create_autocmd("BufLeave", {
		buffer = utils_state[cmd].buf,
		callback = function()
			if
				utils_state[cmd].is_open
				and utils_state[cmd].win
				and vim.api.nvim_win_is_valid(utils_state[cmd].win)
			then
				vim.api.nvim_win_close(utils_state[cmd].win, false)
			end
			utils_state[cmd].win = nil
			utils_state[cmd].is_open = false
		end,
		once = true,
	})
end

-- 快捷键映射
vim.keymap.set("n", "<leader>gg", function()
	FloatingTerminal("lazygit")
end, { silent = true, desc = "Toggle Lazygit" })

vim.keymap.set("n", "<leader>tt", function()
	FloatingTerminal("bash")
end, { noremap = true, silent = true, desc = "Toggle floating terminal" })
