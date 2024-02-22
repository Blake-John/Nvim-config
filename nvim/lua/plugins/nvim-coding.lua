return {
	-- add the auto pairs such as () "" {} []
	{
		"echasnovski/mini.pairs",
		event = "InsertEnter",
		opts = {},
		config = function ()
			require ("mini.pairs").setup ()
		end,
	},

	-- add the comment function (optional)
	-- {
	-- 	'echasnovski/mini.comment',
	-- 	version = '*',
	-- 	event = "VeryLazy",
	-- 	-- opts = {},
	-- 	config = function ()
	-- 		require ("mini.comment").setup ()
	-- 	end,
	-- },


	-- add the cmp for auto code completion
	{
		"hrsh7th/nvim-cmp",
		version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"onsails/lspkind.nvim",
			"saadparwaiz1/cmp_luasnip",
			-- { 
			-- 	"tzachar/cmp-fuzzy-buffer",
			-- 	-- dependencies = {
			-- 	-- 	"tzachar/fuzzy.nvim",
			-- 	-- 	"nvim-telescope/telescope-fzf-native.nvim"
			-- 	-- },
			-- },
			-- "tzachar/cmp-fuzzy-path",
			-- "hrsh7th/cmp-vsnip",
			-- "hrsh7th/vim-vsnip",
		},
		config = function ()
			require ("cmp").setup ({
				-- auto select the first item
				completion = { completeopt = "menu, menuone, noinsert" },

				-- select the completion/snippets engine
				snippets = {
					expand = function (args)
						-- vim.fn["vsnip#anonymous"](args.body) -- For 'vsnip' ysers
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
						-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
						-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
					end,
				},

				-- select the snippets sources
				sources = require ("cmp").config.sources ({
					-- { name = 'vsnip', priority = 1000 }, -- For vsnip users.
					{ name = 'luasnip' }, -- For luasnip users.
					-- { name = 'ultisnips' }, -- For ultisnips users.
					-- { name = 'snippy' }, -- For snippy users.					{ name = 'buffer' },
					{ name = "nvim_lsp", priority = 900 },
					{ name = "buffer", priority = 800 },
					{ name = "path", priority = 700 },
				}),

				-- the keymaps
				mapping = require ("cmp").mapping.preset.insert ({
					--select the item
					["<CR>"] = require ("cmp").mapping.confirm ({ select = true }),
					["<tab>"] = require ("cmp").mapping.confirm ({ select = true }),
					-- change the item
					["<Up>"] = require ("cmp").mapping.select_prev_item (),
					["<Down>"] = require ("cmp").mapping.select_next_item (),
					-- close the window
					["<esc>"] = require ("cmp").mapping ({
						i = require ("cmp").mapping.abort (),
						c = require ("cmp").mapping.close (),
					}),
					-- page up/Down
					["<C-Up>"] = require ("cmp").mapping (
						require ("cmp").mapping.scroll_docs (-4),
						{ 'i', 'c' }
					),
					["<C-Down>"] = require ("cmp").mapping (
						require ("cmp").mapping.scroll_docs (4),
						{ 'i', 'c' }
					),
				}),

				-- the snippet windows
				windows = {
					completion = require ("cmp").config.window.bordered(),
					documentation = require ("cmp").config.window.bordered(),
				},

				-- the search snippets
				require ("cmp").setup.cmdline ('/', { source = {{ name = "buffer" }}}),

				-- the snippet format
				formatting = {
					-- the snippets abbrev, input type, the menu
					fields = { "abbr", "kind", "menu"},
					format = require ("lspkind").cmp_format ({
						mode = 'symbol_text', -- show only symbol annotations
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
								vsnip = "[Snippet]",
								path = "[Path]",
								buffer = "[Buffer]",
							})[entry.source.name]
							return vim_item
						end,
					})
				},
			})
		end,
	},
}
