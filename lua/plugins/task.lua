local M = {}
local state = {
	win = nil,
	buf = nil,
	tasks = {},
	last_task = nil,
}
local task = {
	win = nil,
	buf = nil,
	cmd = "echo Hello Task !",
}

-- 1. 读取项目 tasks.json
local function load_tasks()
	local cwd = vim.fn.getcwd()
	local path1 = cwd .. "/tasks.json"
	local path2 = cwd .. "/.nvim/tasks.json"
	local path3 = "~/.nvim/tasks.json"

	-- 文件不存在
	if vim.fn.filereadable(path1) == 0 and vim.fn.filereadable(path2) == 0 and vim.fn.filereadable(path3) == 0 then
		vim.notify("未找到 tasks.json: " .. path1, vim.log.levels.WARN)
		return {}
	end

	-- 读取并解析 JSON
	local path = path1
	if vim.fn.filereadable(path1) == 1 then
		path = path1
	elseif vim.fn.filereadable(path2) == 1 then
		path = path2
	elseif vim.fn.filereadable(path3) == 1 then
		path = path3
	end

	local content = table.concat(vim.fn.readfile(path), "\n")
	-- vim.notify(content, vim.log.levels.INFO)
	local ok, data = pcall(vim.json.decode, content)
	if not ok or not data.tasks and not data.task then
		vim.notify("tasks.json 格式错误", vim.log.levels.ERROR)
		return {}
	end

	if data.task then
		return data.task
	end
	return data.tasks
end

-- 2. 打开浮动窗口
local function open_float()
	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.5)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	state.buf = vim.api.nvim_create_buf(false, true)
	state.win = vim.api.nvim_open_win(state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		border = "rounded",
		style = "minimal",
	})

	vim.wo[state.win].winblend = 0
	vim.wo[state.win].winhighlight = "Normal:FloatingTermNormal,FloatBorder:FloatingTermBorder"
	vim.wo[state.win].cursorline = true -- 开启光标行高亮

	-- 关闭操作
	vim.keymap.set("n", "<ESC>", function()
		vim.api.nvim_win_close(state.win, true)
	end, { buffer = state.buf, silent = true })
end

-- 3. 渲染任务列表
local function render_list(tasks)
	local lines = {}
	for i, t in ipairs(tasks) do
		table.insert(lines, i .. ". " .. t.name .. " - " .. t.cmd)
	end
	vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
	vim.bo[state.buf].modifiable = false
end

-- 4. 执行任务（浮动终端运行）
local function run_task(cmd)
	state.last_task = cmd
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_close(state.win, true)
		state.win = nil
	end
	if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
		vim.api.nvim_buf_delete(state.buf, { force = true })
		state.buf = nil
	end

	task.buf = vim.api.nvim_create_buf(false, true)
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	task.win = vim.api.nvim_open_win(task.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	})

	-- 🔥 核心：监听退出码，失败则停留不关闭
	vim.fn.termopen(cmd, {
		on_exit = function(_, exit_code)
			if exit_code == 0 then
				-- 成功：1秒后自动关闭
				vim.defer_fn(function()
					if task.buf and vim.api.nvim_buf_is_valid(task.buf) then
						vim.api.nvim_buf_delete(task.buf, { force = true })
						task.buf = nil
					end
					if task.win and vim.api.nvim_win_is_valid(task.win) then
						vim.api.nvim_win_close(task.win, true)
						task.win = nil
					end
				end, 1000)
				vim.notify("✅ 任务执行成功", vim.log.levels.INFO)
			else
				-- 失败：停留，不关闭
				vim.notify("❌ 任务执行失败 (code: " .. exit_code .. ")", vim.log.levels.ERROR)
				-- 按 q 手动关闭
				vim.keymap.set("n", "q", function()
					vim.api.nvim_win_close(task.win, false)
					vim.api.nvim_buf_delete(task.buf, { force = true })
					task.win = nil
					task.buf = nil
				end, { buffer = task.buf, silent = true })
			end
		end,
	})

	vim.cmd.startinsert()
end

-- 5. 绑定回车选择任务
local function setup_mapping(tasks)
	vim.keymap.set("n", "<CR>", function()
		local line = vim.fn.line(".")
		print(line)
		local task = tasks[line]
		if task then
			run_task(task.cmd)
		end
	end, { buffer = state.buf, silent = true })
end

-- 6. 🔥 新增：执行上次任务
function M.run_last()
	if not state.last_task then
		vim.notify("🔸 暂无执行记录", vim.log.levels.INFO)
		return
	end
	run_task(state.last_task)
end

-- 入口函数：打开任务面板
function M.open()
	state.tasks = load_tasks()
	if #state.tasks == 0 then
		return
	end

	open_float()
	render_list(state.tasks)
	setup_mapping(state.tasks)
end

vim.keymap.set("n", "<leader>tA", function()
	M.open()
end, { desc = "toggle tasks" })

vim.keymap.set("n", "<S-A-t>", function()
	M.open()
end, { desc = "toggle tasks" })

vim.keymap.set("n", "<leader>ta", function()
	M.run_last()
end, { desc = "run last tasks" })

vim.keymap.set("n", "<M-t>", function()
	M.run_last()
end, { desc = "run last tasks" })

return M
