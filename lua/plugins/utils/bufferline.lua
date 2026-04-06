return {
	"akinsho/bufferline.nvim",
	version = "*",
	event = "BufRead",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				numbers = function(opts)
					return string.format("%s", opts.raise(opts.ordinal))
				end,
				themable = true,
				offsets = {
					{
						filetype = "NvimTree",
						text = "File Explorer",
						text_align = "center",
						separator = true,
					},
				},
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = e == "error" and " " or (e == "warning" and " " or " ")
						s = s .. n .. sym
					end
					return s
				end,
				show_buffer_close_icons = false,
				groups = {
					items = {
						require("bufferline.groups").builtin.pinned:with({ icon = "" }),
					},
				},
			},
		})
	end,
}
