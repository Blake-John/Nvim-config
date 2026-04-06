return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	cmd = "FzfLua",
	opts = {
		-- 全局默认值（所有命令共享）
		winopts = {
			border = "rounded",
			backdrop = 30,
			preview = {
				highlight = true,
			},
		},
		fzf_opts = {
			["--layout"] = "reverse",
			["--prompt"] = "❯ ",
		},

		-- 📁 文件搜索：居中 + 右侧预览（默认布局）
		files = {
			profile = {
				"ivy",
			},
		},

		-- 🔍 全局搜索(Grep)：底部 Ivy 布局 + 隐藏预览（专注结果）
		grep = {
			-- winopts = { height = 0.45, row = 0.95, width = 1.0, preview = { hidden = false } },
			-- fzf_opts = { ["--prompt"] = "🔍 Grep> " },
			-- rg_opts = "--column --line-number --no-heading --max-columns=4096 --color=always",
			profile = {
				"ivy",
			},
		},

		-- 📑 缓冲区切换：无预览 + 紧凑列表
		buffers = {
			winopts = { height = 0.65, width = 0.35, preview = { hidden = true } },
			fzf_opts = { ["--prompt"] = "📑 Buffers> " },
		},

		-- 🌐 LSP 符号/定义/引用：灵活布局 + 小预览
		lsp = {
			winopts = {
				height = 0.6,
				preview = { layout = "flex", flip_columns = 100, title_pos = "left" },
			},
			fzf_opts = { ["--prompt"] = "🔗 LSP> " },
		},

		-- 🌿 Git 状态：无边框 + 左侧预览
		git = {
			winopts = { border = "single", preview = { layout = "horizontal", vertical = "up:50%" } },
		},

		-- 🎨 命令/帮助：极简 + 无预览
		commands = {
			winopts = { height = 0.5, preview = { hidden = true } },
			fzf_opts = { ["--prompt"] = "⌨️ Commands> " },
		},
	},
}
