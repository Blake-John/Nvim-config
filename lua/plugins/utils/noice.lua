-- if true then
-- 	return {}
-- end
return {
	"folke/noice.nvim",
	keys = { ":", "/" },
	event = "BufReadPre",
	opts = {
		-- add any options here
		presets = {
			lsp_doc_border = true,
			-- bottom_search = true,
		},
		messages = {
			view_error = "messages",
		},
		popupmenu = { enabled = true, backend = "nui" },
		views = {
			popupmenu = {
				border = {
					style = "rounded",
				},
			},
		},
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
	},
	config = function(_, opts)
		vim.o.winborder = ""
		require("noice").setup(opts)
	end,
}
