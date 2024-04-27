-- print ("load whichkey.lua")

return {
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		init = function ()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
		end,
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["<leader>"] = { name = "normal" },
				["<leader>s"] = { name = "search" },
				["<leader>b"] = { name = "buffer" },
				["<leader>bc"] = { name = "close buffers" },
				["<leader>d"] = { name = "Debug" },
				["<leader>dr"] = { name = "run" }
			},
			window = {
				-- border = "single"
				border = "rounded"
			}
		},
		config = function (_, opts)
			require ("which-key").setup (opts)
			require ("which-key").register (opts.defaults)
		end
	}
}
