return {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPre",
	build = ":TSUpdate",
	opts = {
		-- highlight = {
		-- 	enable = true,
		-- },
		-- incremental_selection = {
		-- 	enable = true,
		-- 	keymaps = {
		-- 		init_selection = "gs",
		-- 		node_incremental = "<CR>",
		-- 		scope_incremental = "<A-CR>",
		-- 		node_decremental = "<BS>",
		-- 	},
		-- },
	},
}
