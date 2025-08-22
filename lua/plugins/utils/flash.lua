return {
	"folke/flash.nvim",
	keys = {
		{
			"s",
			mode = { "n", "v", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash",
		},
		"f",
	},
	opts = {},
}
