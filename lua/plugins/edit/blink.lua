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
			default = { "avante", "lsp", "path", "crates", "snippets", "buffer" },
			providers = {
				avante = {
					module = "blink-cmp-avante",
					name = "Avante",
				},
				crates = {
					name = "crates",
					module = "blink.compat.source",
				},
			},
		},
		completion = {
			menu = {
				border = "rounded",
			},
			documentation = {
				auto_show = true,
				window = {
					border = "rounded",
				},
			},
		},
		signature = {
			window = {
				border = "rounded",
			},
		},
	},
}
