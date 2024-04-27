return {
	{
		-- the snip server
		"L3MON4D3/LuaSnip",
		event = "InsertEnter",
		-- follow latest release.
		version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
		-- install jsregexp (optional!).
		build = "make install_jsregexp",
		opts = {
			history = true,
			delete_check_events = "TextChanged",
		},

		keys = {
			{
				"<tab>",
				function()
					return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
				end,
				expr = true, silent = true, mode = "i",
			},
			{ "<tab>", function() require("luasnip").jump(1) end, mode = "s" },
			{ "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
		},
		config = function ()
			require ("luasnip.loaders.from_vscode").lazy_load ({
				paths = { "~/.config/nvim/lua/plugins/snippets/" },
				include = { "python", "cpp", "all", "cmake", "lua" },
			})
		end,
	},

	-- {
	-- 	-- the snippets source
	-- 	"rafamadriz/friendly-snippets",
	-- 	-- config = function()
	-- 	-- 	-- require ("luasnip.loaders.from_vscode").lazy_load ({ exclude = all })
	-- 	-- 	require ("luasnip.loaders.from_vscode").lazy_load ({ path = { "./my-snippets" }})
	-- 	-- end,
	-- },
	
	{
		"danymat/neogen",
		event = "InsertEnter",
    		dependencies = { "nvim-treesitter/nvim-treesitter" },
		keys = {
			{"<leader>g", "<cmd>Neogen<CR>", desc = "Generatre Comments String" }
		},
		config = function ()
			require ("neogen").setup ({
				snippet_engine = "luasnip"
			})
		end
	}
}
