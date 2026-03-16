return {
	{
		"mason-org/mason-lspconfig.nvim",
		ft = "cpp",
		cmd = "LspInstall",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed or {}, { "clangd" } or {})
			vim.list_extend(opts.automatic_enable or {}, { "clangd" } or {})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed or {}, { "clangd" } or {})
		end,
	},
}
