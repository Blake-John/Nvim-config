return {
	{
		"folke/snacks.nvim",
		event = { "VimEnter", "VeryLazy" },
		opts = {
			explorer = { enabled = true },
			indent = { enabled = true },
			picker = {
				enabled = true,
				layout = {
					preset = "ivy",
				},
			},
			lazygit = { enabled = true },
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			input = {
				enabled = true,
				win = {
					relative = "cursor",
				},
			},
			toggle = {
				enabled = true,
			},
			notifier = { enabled = true },
		},
	},
}
