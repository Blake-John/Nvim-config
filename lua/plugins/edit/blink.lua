return {
	"saghen/blink.cmp",
	event = "VeryLazy",
	version = "1.",
	dependencies = {
		"Kaiser-Yang/blink-cmp-avante",
		"saghen/blink.compat",
		"rafamadriz/friendly-snippets",
	},
	opts = {
		keymap = {
			preset = "default",
			["<esc>"] = {
				"cancel",
				"fallback",
			},
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<Enter>"] = { "select_and_accept", "select_accept_and_enter", "fallback" },
		},
		sources = {
			-- Add 'avante' to the list
			default = { "avante", "lsp", "path", "crates", "snippets", "buffer", "minuet" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
				},
				crates = {
					name = "crates",
					module = "blink.compat.source",
				},
				minuet = {
					name = "minuet",
					module = "minuet.blink",
					async = true,
					-- Should match minuet.config.request_timeout * 1000,
					-- since minuet.config.request_timeout is in seconds
					timeout_ms = 3000,
					score_offset = 50, -- Gives minuet higher priority among suggestions
				},
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
