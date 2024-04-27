-- print ("load code.lua")

return {
	{
		"folke/neodev.nvim",
		event = "VeryLazy",
		dependencies = { "folke/neoconf.nvim" },
	},
	{
		{
			"nvim-treesitter/nvim-treesitter",
			event = "VeryLazy"
		},
		{
			"nvim-treesitter/nvim-treesitter-context",
			event = "VeryLazy"
		},
		{
			"nvim-treesitter/nvim-treesitter-textobjects",
			event = "VeryLazy"
		}
	},
	
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		version = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"saadparwaiz1/cmp_luasnip",
			"onsails/lspkind.nvim"
		},

		config = function ()
			require ("cmp").setup ({
				-- auto select the first item
				completion = { completeopt = "menu, menuone, noinsert" },

				-- select the completion/snippets engine
				snippet = {
					expand = function (args)
						require ("luasnip").lsp_expand (args.body)
					end,
				},
				
				-- select the snippets sources, the priority is advanced when it is larger
				sources = require ("cmp").config.sources ({
					{ name = "luasnip", priority = 1000 },
					{ name = "nvim_lsp", priority = 900 },
					{ name = "buffer", priority = 800 },
					{ name = "path", priority = 700 }
				}),

				mapping = require ("cmp").mapping.preset.insert ({
					-- select the item
					["<CR>"] = require ("cmp").mapping.confirm ({ select = true }),
					["<tab>"] = require ("cmp").mapping.confirm ({ select = true }),

					-- change the item
					["<Up>"] = require ("cmp").mapping.select_prev_item (),
					["<Down>"] = require ("cmp").mapping.select_next_item (),

					-- close the window
					["<esc>"] = require ("cmp").mapping ({
						i = require ("cmp").mapping.abort (),
					-- 	c = require ("cmp").mapping.close ()
					}),

					-- page up/down
					["<C-Up>"] = require ("cmp").mapping (
						require ("cmp").mapping.scroll_docs (-4),
						{ "i", "c" }
					),
					["<C-Down>"] = require ("cmp").mapping (
						require ("cmp").mapping.scroll_docs (4),
						{ "i", "c" }
					)
				}),

				-- set the search snippets
				require ("cmp").setup.cmdline ("/", { source = {{ name = "buffer" }}}),
				
				-- the snippet windows styles
				window = {
					completion = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					},
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }, 
					},
					-- or you can use the default style, but the default style is too thin
					-- completion = require ("cmp").config.window.bordered (),
					-- documentation = require ("cmp").config.window.bordered (),
				},

				formatting = {
					-- the snippets abbrev, input type, the menu
					fields = { "abbr", "kind", "menu"},
					format = require ("lspkind").cmp_format ({
						mode = 'symbol_text', -- show only symbol and text annotations
						maxwidth = 30,
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as 
						-- maxwidth = function() return math.floor(0.45 * vim.o.columns) end,
						ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
						show_labelDetails = true, -- show labelDetails in menu. Disabled by default

						-- The function below will be called before any actual modifications from lspkind
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						before = function (entry, vim_item)
							-- set the showing text in the menu
							vim_item.menu = ({
								nvim_lsp = "[LSP]",
								luasnip = "[Snip]",
								path = "[Path]",
								buffer = "[Buffer]",
							})[entry.source.name]
							return vim_item
						end
					})
				}
			})
		end
	},

	-- add the auto pairs such as () "" '' {} []
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {},
		config = function ()
			require ("mini.pairs").setup ()
		end
	}

}
