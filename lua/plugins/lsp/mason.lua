return {
	{
		"mason-org/mason.nvim",
		cmd = "Mason",
		opts = {
			ensure_installed = {
                "lua_ls",
				"stylua",
				"shfmt",
				"shellcheck",
			},
		},
	},
}
