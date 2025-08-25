return {
	{
		"mason-org/mason-lspconfig.nvim",
		cmd = "LspInstall",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed or {}, { "cssls" } or {})
			vim.list_extend(opts.automatic_enable or {}, { "cssls" } or {})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed or {}, { "prettierd" } or {})
		end,
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
