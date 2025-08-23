return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = "BufReadPre",
		cmd = "LspInstall",
		opts = {
			automatic_enable = {
				"cssls",
			},
		},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ensure_installed = {
						"cssls",
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"norcalli/nvim-colorizer.lua",
		ft = { "scss", "css", "config", "js*", "ts*", "html" },
		opts = {
			"*",
			css = {
				rgb_fn = true,
				css = true,
				css_fn = true,
				RRGGBBAA = true,
			},
		},
	},
	{
		"nvzone/minty",
		cmd = { "Shades", "Huefy" },
		dependencies = {
			"nvzone/volt",
		},
		opts = {},
	},
}
