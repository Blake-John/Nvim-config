return {
	"folke/flash.nvim",
	keys = { {
		"s",
		function()
			require("flash").jump()
		end,
		desc = "Flash",
	} },
	opts = {},
}
