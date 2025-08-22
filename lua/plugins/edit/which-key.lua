return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
		},
		-- config = function()
		-- 	require("which-key").add({
		-- 		{ "g", group = "goto" },
		-- 		{ "<leader>", group = "nomal" },
		-- 		{ "<leader>s", group = "search" },
		-- 		{ "<leader>b", group = "buffer" },
		-- 		{ "<leader>bc", group = "close buffers" },
		-- 		{ "<leader>d", group = "Debug" },
		-- 		{ "<leader>dr", group = "run" },
		-- 	})
		-- 	require("which-key").setup({
		-- 		win = { border = "rounded" },
		-- 		triggers = {
		-- 			{ "<auto>", mode = "nixsotc" },
		-- 			{ "a", mode = { "n", "v" } },
		-- 		},
		-- 	})
		-- end,
	},
}
