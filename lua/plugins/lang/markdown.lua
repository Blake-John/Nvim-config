return {
	{
		"mason-org/mason-lspconfig.nvim",
		event = "BufReadPre",
		cmd = "LspInstall",
		opts = {
			automatic_enable = {
				"marksman",
			},
		},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					ensure_installed = {
						"marksman",
					},
				},
			},
			"neovim/nvim-lspconfig",
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		ft = "markdown",
		opts = {},
	},
}
