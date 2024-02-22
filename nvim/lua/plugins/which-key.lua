return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 300
	end,
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		plugins = { spelling = true },
		defaults = {
			mode = { "n", "v" },
			["g"] = { name = "+goto" },
			["<leader>"] = { name = "normal" },
			["<leader>s"] = { name = "search" },
			["<leader>b"] = { name = "buffer" },
			["<leader>bc"] = { name = "Close Buffer" },
		},
	},

	config = function (_, opts)
		require ("which-key").setup (opts)
		require ("which-key").register (opts.defaults)
	end,
}

