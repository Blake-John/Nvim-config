-- =============================================================================
-- STATUSLINE 配置
-- =============================================================================

-- 1. 辅助工具：高亮组定义
-- -----------------------------------------------------------------------------
local mode_map = {
	n = { "NORMAL", "St_Mode_Normal" },
	i = { "INSERT", "St_Mode_Insert" },
	v = { "VISUAL", "St_Mode_Visual" },
	V = { "V-LINE", "St_Mode_Visual" },
	["\22"] = { "V-BLOCK", "St_Mode_Visual" },
	c = { "COMMAND", "St_Mode_Command" },
	R = { "REPLACE", "St_Mode_Insert" },
	t = { "TERMINAL", "St_Mode_Terminal" },
}
local color_map = {
	Normal = { fg = "#ffffff", bg = "#5694be", bold = true },
	Insert = { fg = "#ffffff", bg = "#46a359", bold = true },
	Visual = { fg = "#ffffff", bg = "#9571e3", bold = true },
	["V-LINE"] = { fg = "#ffffff", bg = "#9571e3", bold = true },
	["V-BLOCK"] = { fg = "#ffffff", bg = "#9571e3", bold = true },
	Command = { fg = "#ffffff", bg = "#d19838", bold = true },
	Replace = { fg = "#ffffff", bg = "#e34c88", bold = true },
	Terminal = { fg = "#ffffff", bg = "#26a69a", bold = true },
}
local function setup_highlights()
	-- 模式颜色 (Mode Colors)
	-- vim.api.nvim_set_hl(0, "St_Mode_Normal",  { fg = "#ffffff", bg = "#5c6bc0", bold = true })
	-- vim.api.nvim_set_hl(0, "St_Mode_Insert",  { fg = "#ffffff", bg = "#66bb6a", bold = true })
	-- vim.api.nvim_set_hl(0, "St_Mode_Visual",  { fg = "#ffffff", bg = "#ffa726", bold = true })
	-- vim.api.nvim_set_hl(0, "St_Mode_Command", { fg = "#ffffff", bg = "#ef5350", bold = true })
	-- vim.api.nvim_set_hl(0, "St_Mode_Terminal",{ fg = "#ffffff", bg = "#26a69a", bold = true })

	-- vim.api.nvim_set_hl(0, "St_Mode_Normal", { fg = "#ffffff", bg = "#5694be", bold = true })
	-- vim.api.nvim_set_hl(0, "St_Mode_Insert", { fg = "#ffffff", bg = "#46a359", bold = true })
	-- vim.api.nvim_set_hl(0, "St_Mode_Visual", { fg = "#ffffff", bg = "#9571e3", bold = true })
	-- vim.api.nvim_set_hl(0, "St_Mode_Command", { fg = "#ffffff", bg = "#d19838", bold = true })
	-- vim.api.nvim_set_hl(0, "St_Mode_Replace", { fg = "#ffffff", bg = "#e34c88", bold = true })
	-- vim.api.nvim_set_hl(0, "St_Mode_Terminal", { fg = "#ffffff", bg = "#26a69a", bold = true })

	vim.api.nvim_set_hl(0, "St_Mode_Normal", color_map.Normal)
	vim.api.nvim_set_hl(0, "St_Mode_Insert", color_map.Insert)
	vim.api.nvim_set_hl(0, "St_Mode_Visual", color_map.Visual)
	vim.api.nvim_set_hl(0, "St_Mode_Command", color_map.Command)
	vim.api.nvim_set_hl(0, "St_Mode_Replace", color_map.Replace)
	vim.api.nvim_set_hl(0, "St_Mode_Terminal", color_map.Terminal)

	for name, colors in pairs(color_map) do
		vim.api.nvim_set_hl(0, "St_Mode_" .. name, colors)
		-- 关键：箭头高亮组，fg=模式bg，bg=StatusLine bg
		vim.api.nvim_set_hl(0, "St_Arrow_" .. name, {
			fg = colors.bg,
			bg = vim.api.nvim_get_hl(0, { name = "StatusLine" }).bg,
		})
	end
	-- Git 颜色
	vim.api.nvim_set_hl(0, "St_Git_Branch", { fg = "#ff79c6" })
	vim.api.nvim_set_hl(0, "St_Git_Add", { fg = "#50fa7b" })
	vim.api.nvim_set_hl(0, "St_Git_Change", { fg = "#f1fa8c" })
	vim.api.nvim_set_hl(0, "St_Git_Delete", { fg = "#ff5555" })

	-- 诊断颜色 (Diagnostics)
	vim.api.nvim_set_hl(0, "St_Diag_Error", { fg = "#f44747", ctermfg = 1 })
	vim.api.nvim_set_hl(0, "St_Diag_Warn", { fg = "#ffcc00", ctermfg = 3 })
	vim.api.nvim_set_hl(0, "St_Diag_Info", { fg = "#00b7ff", ctermfg = 4 })
	-- vim.api.nvim_set_hl(0, "St_Diag_Hint", { fg = "#4fc1ff", ctermfg = 6 })
	vim.api.nvim_set_hl(0, "St_Diag_Hint", { fg = "#9f6fe3", ctermfg = 6 })

	-- 通用颜色
	vim.api.nvim_set_hl(0, "St_Text", { fg = "#abb2bf", bg = "#2c323c" })
	vim.api.nvim_set_hl(0, "St_Normal", { link = "StatusLine" })
end

-- 2. 状态组件函数
-- -----------------------------------------------------------------------------

-- 组件：模式指示器 (带颜色)
local function get_mode()
	local mode = vim.fn.mode()
	local m = mode_map[mode] or { mode, "St_Normal" }
	-- return string.format("%%#%s# %s%%*%%#%s#%%* ", m[2], m[1], m[2])
	return string.format("%%#%s# %s %%#St_Arrow_%s#%%*", m[2], m[1], m[1])
end

-- 组件：Git 信息 (分支 + 差异)
-- 注意：为了获取 diff 数据，强烈建议安装 gitsigns.nvim
local function get_git_info()
	local branch = ""
	local git_dir = vim.fn.finddir(".git", ".;")

	-- 获取分支名
	if git_dir ~= "" then
		if vim.b.gitsigns_head then
			branch = vim.b.gitsigns_head
		else
			-- 回退方案：如果没有 gitsigns
			branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
		end
	end

	if branch == "" then
		return ""
	end

	local diff = ""
	-- 尝试使用 gitsigns 获取 diff 统计
	if vim.b.gitsigns_status_dict then
		local gs = vim.b.gitsigns_status_dict
		local added = (gs.added and gs.added > 0) and string.format("%%#St_Git_Add#+%d", gs.added) or ""
		local changed = (gs.changed and gs.changed > 0) and string.format("%%#St_Git_Change#~%d", gs.changed) or ""
		local removed = (gs.removed and gs.removed > 0) and string.format("%%#St_Git_Delete#-%d", gs.removed) or ""
		diff = added .. changed .. removed
	end

	return string.format("%%#St_Git_Branch# %s%%* %s%%*", branch, diff)
end

-- 组件：诊断信息 (Diagnostics)
local function get_diagnostics()
	if not vim.diagnostic.is_enabled() then
		return ""
	end

	local counts = { 0, 0, 0, 0 } -- Error, Warn, Info, Hint
	local diagnostics = vim.diagnostic.get(0)

	for _, d in ipairs(diagnostics) do
		counts[d.severity] = counts[d.severity] + 1
	end

	local result = {}
	local icons = { " ", " ", " ", " " }
	local groups = { "St_Diag_Error", "St_Diag_Warn", "St_Diag_Info", "St_Diag_Hint" }

	for i = 1, 4 do
		if counts[i] > 0 then
			table.insert(result, string.format("%%#%s#%s%d", groups[i], icons[i], counts[i]))
		end
	end

	if #result == 0 then
		return ""
	end
	return table.concat(result, " ") .. "%*"
end

-- 组件：LSP 客户端
-- 组件：LSP 客户端 (修复版：使用 get_clients 替代 get_active_clients)
local function get_lsp()
	-- 使用新的 API: vim.lsp.get_clients
	-- 参数表 { bufnr = 0 } 表示仅获取当前缓冲区附着的客户端
	local clients = vim.lsp.get_clients({ bufnr = 0 })

	if next(clients) == nil then
		return ""
	end

	local names = {}
	for _, client in ipairs(clients) do
		table.insert(names, client.name)
	end
	return string.format(" %s", table.concat(names, ","))
end

-- 组件：Visual 模式选中字数
local function visual_count()
	-- 先检查模式，不使用任何可能有副作用的调用
	local m = vim.fn.mode()
	if m ~= "v" and m ~= "V" and m ~= "\22" then
		return ""
	end

	-- 极度安全的调用
	local ok, wc = pcall(vim.fn.wordcount)
	if not ok or type(wc) ~= "table" then
		return ""
	end

	local chars = wc.visual_chars or 0
	local lines = wc.visual_lines or 0

	-- 直接返回字符串，不依赖外部参数
	return string.format("%%#St_Text#  %dL/%dC", lines, chars)
end

-- 辅助：获取当前窗口宽度
local function is_window_wide()
	local width = vim.api.nvim_win_get_width(0)
	return width > 100, width > 60 -- 返回两个布尔值：超宽, 中等
end
local function get_file()
	local full_path = vim.fn.expand("%:p") -- 获取绝对路径
	if full_path == "" then
		return "[No Name]"
	end

	local file_name = vim.fn.expand("%:t") -- 仅获取文件名
	local relative_path = vim.fn.expand("%:~:.") -- 尝试相对于 HOME 或 PWD

	-- 策略：
	-- 1. 如果路径很短，显示相对路径
	-- 2. 如果路径很长，只显示文件名
	if #relative_path < 40 then
		return "./" .. relative_path
	else
		return file_name
	end
end
local function file_type()
	local ft = vim.bo.filetype
	local icons = {
		lua = " ",
		python = " ",
		javascript = " ",
		typescript = " ",
		javascriptreact = " ",
		typescriptreact = " ",
		html = " ",
		css = " ",
		scss = " ",
		json = " ",
		markdown = " ",
		vim = " ",
		sh = " ",
		bash = " ",
		zsh = " ",
		rust = " ",
		go = " ",
		c = " ",
		cpp = " ",
		java = " ",
		php = " ",
		ruby = " ",
		swift = " ",
		kotlin = " ",
		dart = " ",
		elixir = " ",
		haskell = " ",
		sql = " ",
		yaml = " ",
		toml = " ",
		xml = " ",
		dockerfile = " ",
		gitcommit = " ",
		gitconfig = " ",
		vue = " ",
		svelte = " ",
		astro = " ",
	}
	if ft == "" then
		return "  "
	end
	return (icons[ft] or "  ")
end

local function file_size()
	local size = vim.fn.getfsize(vim.fn.expand("%"))
	if size < 0 then
		return ""
	end
	local size_str
	if size < 1024 then
		size_str = size .. "B"
	elseif size < 1024 * 1024 then
		size_str = string.format("%.1fK", size / 1024)
	else
		size_str = string.format("%.1fM", size / 1024 / 1024)
	end
	return file_type() .. size_str
end

-- 3. 主组装函数 (响应式版)
-- -----------------------------------------------------------------------------
function _G.statusline_render()
	local is_wide, is_medium = is_window_wide()

	local parts = {}

	-- 左侧：模式 (永远显示)
	table.insert(parts, get_mode())
	table.insert(parts, " ")

	-- 只有中等以上宽度才显示 Git 和 诊断
	if is_medium then
		table.insert(parts, get_git_info())
		table.insert(parts, " ")
		table.insert(parts, get_diagnostics())
		table.insert(parts, " ")
	end

	-- 文件名 (永远显示)
	-- table.insert(parts, "%f %h%m%r")
	table.insert(parts, get_file())
	table.insert(parts, " ")
	table.insert(parts, "%h%m%r")
	table.insert(parts, " ")
	table.insert(parts, file_size())
	table.insert(parts, " ")

	-- 右侧对齐
	table.insert(parts, "%=")

	-- 只有超宽才显示 LSP
	if is_wide then
		table.insert(parts, visual_count())
		table.insert(parts, " ")
		table.insert(parts, get_lsp())
		table.insert(parts, " ")
	end

	-- 行列号 (永远显示)
	table.insert(parts, " %l:%c %P ")

	return table.concat(parts)
end

function _G.statusline_active()
	return table.concat({
		get_mode(),
		-- " ",
		"%f %h%m%r", -- 文件名，帮助标志，修改标志，只读标志
		" ",
		get_git_info(),
		" ",
		get_diagnostics(),
		"%=", -- 左右分隔
		visual_count(),
		"  ",
		get_lsp(),
		"  ",
		" %l:%c %P ", -- 行列号，百分比
	})
end

function _G.statusline_inactive()
	return " %f %h%m%r %= %l:%c "
end

-- 4. 自动命令设置
-- -----------------------------------------------------------------------------
local augroup = vim.api.nvim_create_augroup("UserStatusLine", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = augroup,
	callback = function()
		vim.opt_local.statusline = "%!v:lua.statusline_render()"
		setup_highlights() -- 确保高亮加载
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = augroup,
	callback = function()
		vim.opt_local.statusline = "%!v:lua.statusline_inactive()"
	end,
})

-- 你希望 不渲染自定义状态栏 的文件类型
local disabled_fts = {
	"NvimTree",
	"neo-tree",
	"toggleterm",
	"TelescopePrompt",
	"TelescopeResults",
	"fzf",
	"dashboard",
	"alpha",
	"packer",
	"lazy",
	"help",
	"qf",
	"minifiles",
	"fff_list",
	"fff_input",
	"fff_file_info",
}

local function is_disabled_ft()
	local ft = vim.bo.filetype
	return vim.tbl_contains(disabled_fts, ft)
end

-- 自动命令

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
	group = augroup,
	callback = function()
		if is_disabled_ft() then
			-- 禁用：恢复默认 statusline
			vim.opt_local.statusline = ""
			return
		end
		-- 启用：你的自定义状态栏
		vim.opt_local.statusline = "%!v:lua.statusline_render()"
	end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
	group = augroup,
	callback = function()
		if is_disabled_ft() then
			vim.opt_local.statusline = ""
			return
		end
		vim.opt_local.statusline = "%!v:lua.statusline_inactive()"
	end,
})

-- 初始化高亮
setup_highlights()
