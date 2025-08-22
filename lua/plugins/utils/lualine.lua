-- if true then
-- 	return {}
-- end
return {
	{
		"nvim-lualine/lualine.nvim",
		event = "BufReadPre",
		dependencies = { "echasnovski/mini.icons" },
		opts = {
			sections = {
				lualine_x = {
					"lsp_status",
					"filetype",
				},
				lualine_z = {
					"location",
				},
			},
		},
	},
}
