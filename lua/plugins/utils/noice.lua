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
		lsp = {
			hover = { enabled = false },
			signature = { enabled = false },
			-- 	override = {
			-- 		["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			-- 		["vim.lsp.util.stylize_markdown"] = true,
			-- 	},
		},
		popupmenu = { enabled = false, backend = "nui" },
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
	-- if you want to let noice take the popupmenu and then
	-- set the original winborder to be none
	-- uncomment bellow
	-- config = function(_, opts)
	-- 	vim.o.winborder = ""
	-- 	require("noice").setup(opts)
	-- end,
}
