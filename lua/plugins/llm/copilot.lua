return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			-- only for blink completion
			require("copilot").setup({
				suggestion = {
					enabled = false,
					auto_trigger = false, -- 使用 next prev accept 触发
					hide_during_completion = true, -- 🔑 关键：与补全菜单共存时不重叠显示
					debounce = 100, -- 防抖延迟（ms），值越小越灵敏但耗资源
					keymap = {
						accept = "<A-l>", -- 接受完整建议
						-- accept_word = "<A-w>", -- 接受下一个词
						-- accept_line = "<A-S-l>", -- 接受整行
						next = "<C-]>", -- 切换下一个建议
						prev = "<C-[>", -- 切换上一个建议
						dismiss = "<A-h>", -- 拒绝/隐藏当前建议
						toggle_auto_trigger = false,
					},
				},
				nes = {
					enabled = false, -- requires copilot-lsp as a dependency
					auto_trigger = false,
					keymap = {
						accept_and_goto = false,
						accept = false,
						dismiss = false,
					},
				},
				panel = {
					enabled = false,
				},
			})
		end,
	},
	{
		"olimorris/codecompanion.nvim",
		cmd = { "CodeCompanion", "CodeCompanionChat" },
		event = "InsertEnter",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"j-hui/fidget.nvim",
		},
		init = function()
			require("config.codecompanion-spin"):init()
		end,
		config = function()
			require("codecompanion").setup({
				strategies = {
					chat = {
						adapter = "copilot",
						model = "gpt-5-mini",
					},
					inline = {
						adapter = "copilot",
					},
					cmd = {
						adapter = "copilot",
					},
				},
				interactions = {
					chat = {
						adapter = "copilot",
						model = "gpt-5-mini",
					},
				},
				display = {
					chat = {
						window = {
							layout = "vertical",
							position = "right",
							width = 0.35,
							border = "rounded",
						},
						show_token_count = true,
					},
					diff = {
						enabled = true,
					},
				},

				-- NOTE: The log_level is in `opts.opts`
				opts = {
					log_level = "DEBUG",
					language = "Chinese",
				}, -- NOTE: The log_level is in `opts.opts`
			})
		end,
	},
}
