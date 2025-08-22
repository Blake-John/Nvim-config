return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPre",
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "gs",
					node_incremental = "<CR>",
					scope_incremental = "<C-CR>",
					node_decremental = "<S-CR>",
				},
			},
		})
	end,
}
