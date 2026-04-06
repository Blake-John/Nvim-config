return {
	"saghen/blink.cmp",
	event = "VeryLazy",
	version = "1.",
	dependencies = {
		-- "Kaiser-Yang/blink-cmp-avante",
		"saghen/blink.compat",
		"rafamadriz/friendly-snippets",
		"fang2hou/blink-copilot",
	},
	opts = {
		keymap = {
			preset = "default",
			["<esc>"] = {
				"cancel",
				"fallback",
			},
			["<Tab>"] = { "select_and_accept", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<Enter>"] = { "select_and_accept", "select_accept_and_enter", "fallback" },
			["<C-n>"] = { "select_next" },
			["<C-p>"] = { "select_prev" },
		},
		sources = {
			-- Add 'avante' to the list
			default = { "lsp", "path", "copilot", "crates", "snippets", "buffer" },
			providers = {
				-- avante = {
				-- 	module = "blink-cmp-avante",
				-- 	name = "Avante",
				-- },
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
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
			per_filetype = {
				codecompanion = { "codecompanion" },
			},
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
	},
}
