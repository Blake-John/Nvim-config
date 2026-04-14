vim.pack.add({
	{
		src = "https://github.com/saghen/blink.cmp",
		version = "v1.10.2",
	},
	"https://github.com/saghen/blink.compat",
	"https://github.com/rafamadriz/friendly-snippets",
	"https://github.com/stevearc/conform.nvim",
})

local autocmd = vim.api.nvim_create_autocmd
local map = vim.keymap.set

autocmd("InsertEnter", {
	once = true,
	callback = function()
		vim.cmd.packadd("blink.cmp")
		vim.cmd.packadd("friendly-snippets")
		vim.cmd.packadd("conform.nvim")

		require("blink.cmp").setup({
			keymap = {
				preset = "default",
				["<esc>"] = { "cancel", "fallback" },
				["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
				["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
				["<CR>"] = { "select_and_accept", "select_accept_and_enter", "fallback" },
				["<C-n>"] = { "select_next" },
				["<C-p>"] = { "select_prev" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
			sources = {
				-- default = { "lsp", "path", "copilot", "crates", "snippets", "buffer" },
				default = { "lsp", "path", "crates", "snippets", "buffer" },
				providers = {
					-- avante = {
					-- 	module = "blink-cmp-avante",
					-- 	name = "Avante",
					-- },
					-- copilot = {
					--     name = "copilot",
					--     module = "blink-copilot",
					--     score_offset = 100,
					--     async = true,
					-- },
					crates = {
						name = "crates",
						module = "blink.compat.source",
					},
					-- minuet = {
					-- 	name = "minuet",
					-- 	module = "minuet.blink",
					-- 	async = true,
					-- 	-- Should match minuet.config.request_timeout * 1000,
					-- 	-- since minuet.config.request_timeout is in seconds
					-- 	timeout_ms = 3000,
					-- 	score_offset = 50, -- Gives minuet higher priority among suggestions
					-- },
				},
				-- per_filetype = {
				-- 	codecompanion = { "codecompanion" },
				-- },
			},
			snippets = {
				preset = "default",
			},
			completion = {
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", gap = 1 },
						},
					},
				},
				documentation = {
					auto_show = true,
					window = {
						border = "rounded",
					},
				},
				-- Recommended to avoid unnecessary request
				trigger = { prefetch_on_insert = false },
			},
			signature = {
				enabled = true,
				window = {
					border = "rounded",
				},
			},
		})
		require("conform").setup({
			formatters_by_ft = {
				bash = { "shfmt" },
				lua = { "stylua" },
				rust = { "rustfmt" },
				python = { "ruff" },
				markdown = { "markdownlint" },
				cpp = { "clang-format" },
				-- css = { "prettier" },
				-- html = { "prettier" },
			},
			format_after_save = { lsp_format = "fallback" },
		})
	end,
})

-- 使用 lsp formatter 比较慢，专用的 formatter 比较快
-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*",
--     callback = function(args)
--         -- 异步格式化，不阻塞保存
--         vim.lsp.buf.format({
--             bufnr = args.buf,
--             async = true, -- 👈 关键：异步！不卡
--         })
--     end,
-- })

-- vim.api.nvim_create_autocmd("BufWritePre", {
--     pattern = "*",
--     callback = function(args)
--         require("conform").format({ bufnr = args.buf })
--     end,
-- })
