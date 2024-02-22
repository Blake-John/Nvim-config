-- this file is to config the plugins for the search/find function

return {
	-- the flash for more easily jumping to target
	{
		"folke/flash.nvim",
		-- event = "VeryLazy",
		vscode = true,
		keys = {
			{ "s", mode = {"n", "x", "o" }, function () require ("flash").jump () end, desc = "Flash" },
		},
	},


	-- the telescope for the file/cmds/keymaps ... searching
	{
		"nvim-telescope/telescope.nvim",
		tag = '0.1.5',
		dependencies = { "nvim-lua/plenary.nvim" },
		-- event = "VeryLazy",
		keys = {
			{ "<leader>sb", ":Telescope buffers<CR>", desc = "Search Buffers" },
			{ "<leader>sc", ":Telescope commands<CR>", desc = "Search Commands" },
			{ "<leader>sd", ":Telescope diagnostics<CR>", desc = "Search Diagnostics" },
			{ "<leader>sf", ":Telescope fd<CR>", desc = "Search Files" },
			{ "<leader>sh", ":Telescope help_tags<CR>", desc = "Search Help_tags" },
			{ "<leader>sk", ":Telescope keymaps<CR>", desc = "Search Keymaps" },
			{ "<leader>ss", ":Telescope live_grep<CR>", desc = "Search Any" },
		},
	},
	

	-- optional plugins for enhancing telescope
	-- {
	-- 	"nvim-telescope/telescope-file-browser.nvim",
	-- 	event = "VeryLazy",
	-- },

	-- {
	-- 	"nvim-telescope/telescope-fzf-native.nvim",
	-- 	event = "VeryLazy",
	-- },


	-- search and replace
	{
		"nvim-pack/nvim-spectre",
		-- event = "VeryLazy",
		opts = {
			-- the option can set the spectre to search in swap_files/buffers
			open_cmd = "noswapfile vnew"
		},
		keys = {
			{ "<leader>sr", ":Spectre<CR>", desc = "Search and Replace" },
		},
	}
}
