return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = "BufReadPre",
		cmd = "LspInstall",
		opts = {
			automatic_enable = {
				"lua_ls",
			},
		},
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()
			vim.diagnostic.config({
				signs = {
					-- 一次性定义 4 个级别的图标
					text = {
						[vim.diagnostic.severity.ERROR] = "󰅚",
						[vim.diagnostic.severity.WARN] = "󰀪",
						[vim.diagnostic.severity.HINT] = "󰌶",
						[vim.diagnostic.severity.INFO] = "󰋽",
					},
					-- 保留 1 个字符宽度的固定列，避免整行左右抖动
					numhl = false,
				},
				underline = true,
				update_in_insert = true,
				severity_sort = true,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
			})
		end,
	},
}
