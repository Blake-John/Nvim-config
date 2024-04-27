return {
	{
		"folke/flash.nvim",
		keys = {
			{ "s", mode = { "n", "x", "o" }, function () require ("flash").jump () end, desc = "Flash" }
		}
	},

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.5",
		dependencies = { "nvim-lua/plenary.nvim" },

		keys = {
			{ "<leader>sb", ":Telescope buffers<CR>", desc = "Search Buffers" },
			{ "<leader>sc", ":Telescope commands<CR>", desc = "Search Commands" },
			{ "<leader>sd", ":Telescope diagnostics<CR>", desc = "Search Diagnostics" },
			{ "<leader>sf", ":Telescope fd<CR>", desc = "Search Files" },
			{ "<leader>sh", ":Telescope help_tags<CR>", desc = "Search Help_tags" },
			{ "<leader>sk", ":Telescope keymaps<CR>", desc = "Search Keymaps" },
			{ "<leader>ss", ":Telescope live_grep<CR>", desc = "Search Any" },
			{ "<leader>sp", ":Telescope projects<CR>", desc = "Search Projects" },
		}
	},

	{
		"nvim-pack/nvim-spectre",
		opts = { open_cmd = "noswapfile vnew" },
		keys = {{ "<leader>sr", "<cmd>Spectre<CR>", desc = "Search and Replace" }}
	}
}
