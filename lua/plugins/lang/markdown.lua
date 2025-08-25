return {
	{
		"mason-org/mason-lspconfig.nvim",
		ft = "markdown",
		cmd = "LspInstall",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed or {}, { "marksman" } or {})
			vim.list_extend(opts.automatic_enable or {}, { "marksman" } or {})
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		opts = {
			file_types = { "markdown", "Avante" },
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed or {}, { "markdownlint" } or {})
		end,
	},
}
