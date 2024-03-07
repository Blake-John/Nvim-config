-- this file is to config the nvim ui to be more convenient to operate

return {
	
	-- the colorscheme of the nvim
	-- {
  --   "folke/tokyonight.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
	-- 	plugins = {
	-- 		treesitter = true,
	-- 	},
  --   config = function()
  --     -- load the colorscheme here
	-- 		require ("tokyonight").setup ({
	-- 			plugins = {
	-- 				treesitter = false,
	-- 				cmp = false,
	-- 			},
	-- 		})
  --     -- vim.cmd([[colorscheme tokyonight-night]])
  --   end,
	-- },

	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function ()
			require ("onedarkpro").setup ({
				styles = {
					comments = "italic",
				},
				options = {
					terminal_colors = false,
					cursorline = true,
				},
				-- plugins = {
				-- 	treesitter = false,
				-- },
				highlights = {
					-- Number
					["@number"] = { fg = "#6C71C4" },
					["@float"] = { fg = "#6C71C4" },

					-- Identifier - variable name
					["@text.reference"] = { fg = "#2AA198" },
					["@parameter"] = { fg = "#2AA198" },
					["@field"] = { fg = "#2AA198" },
					["@property"] = { fg = "#2AA198" },
					["@variable"] = { fg = "#2AA198" },
					
					-- Function - function name and method file_name
					["@function"] = { fg = "#268BD2" },
					["@function.builtin"] = { fg = "#268BD2" },
					["@method"] = { fg = "#268BD2" },
					["@constructor"] = { fg = "#268BD2" },

					-- Keyword
					["@statement"] = { fg = "#d33682" }, -- any statement
					["@conditional"] = { fg = "#d33682" }, -- if, then, else, switch
					["@repeat"] = { fg = "#d33682" }, -- for, do, while
					["@label"] = { fg = "#d33682" }, -- case, default
					["@keyword"] = { fg = "#d33682" }, -- other Keyword
					["@exception"] = { fg = "#d33682" }, --try, catch
					["@structure"] = { fg = "#d33682" },
					["@define"] = { fg = "#d33682" },
					["@include"] = { fg = "#d33682" }, -- #include

					-- special target
					["@storageclass"] = { fg = "#CB4B16" }, -- static, register, volatile
					["@constant"] = { fg = "#ef662c" },
					["@constant.builtin"] = { fg = "#ef662c" },
					-- ["@operator"] = { fg = "#CB4B16" }, -- sizeof + - =

					-- Type
					["@type"] = { fg = "#d39f03" }, -- int long double float char
					["@type.definition"] = { fg = "#d39f03" }, -- a typedef

					-- Namespace
					["@namespace"] = { fg = "#c86f09" },

					-- Some Specific overide for the cpp
					Number = { fg = "#6C71C4" },
					StorageClass = { fg = "#CB4B16" },
					Conditional = { fg = "#d33682" },
					Statement = { fg = "#d33682" },
					Include = { fg = "#d33682" },
					-- Macro = { fg = "#d33682" },
					Structure = { fg = "#d33682" },
					Repeat = { fg = "#d33682" }
				}
			})
			vim.cmd("colorscheme onedark")
		end,
	},


	-- file explorer tree at the left side
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		keys = {
			{
				"<leader>e",
				function()
					require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
				end,
				desc = "Explorer"
			},
		},
		config = function ()
			require ("neo-tree").setup ({
				window = {
					width = 20,
				}
			})
		end,
	},


	-- the tabs bar of the buffers
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		event = "VeryLazy",

		-- setup the plugins
		config = function ()
			require ("bufferline").setup ()
		end,
	},


	-- the mini utils to enhance the usage
	-- all the mini utils need to be configure by setup ()
	{
		-- add the animation of the cursor movement
		{
			'echasnovski/mini.animate',
			version = false,
			event = "VeryLazy",
			config = function ()
				require ("mini.animate").setup ()
			end,
		},

		-- add the indent highlight
		{
			"echasnovski/mini.indentscope",
			event = "VeryLazy",
			opts = {
				-- symbol = "▏",
				-- what character to draw the line
				symbol = "│",
				options = { try_as_border = true },
			},
			-- use opts as the setup parameter to config the util
			config = function (_, opts)
				require('mini.indentscope').setup(opts)
			end,
			-- or you can config it like : 
			-- require ("mini.indentscope").setup ({
			--   symbol = "│",
			--   options = { try_as_border = true },
			-- })
		},

	},

	-- add the indent hint
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		config = function ()
			require ("ibl").setup ({
				exclude = {
					filetypes = { "dashboard" }
				}
			})
		end,

	},

	-- add the winbar to show the struct
	{
		"fgheng/winbar.nvim",
		event = "VeryLazy",
		config = function ()
			require ("winbar").setup ({
				enabled = true,

				show_file_path = true,
				show_symbols = true,

				colors = {
						path = '', -- You can customize colors like #c946fd
						file_name = '',
						symbols = '',
				},

				icons = {
						file_icon_default = '',
						seperator = '>',
						editor_state = '●',
						lock_icon = '',
				},

				exclude_filetype = {
						'help',
						'startify',
						'dashboard',
						'packer',
						'neogitstatus',
						'NvimTree',
						'Trouble',
						'alpha',
						'lir',
						'Outline',
						'spectre_panel',
						'toggleterm',
						'qf',
				}
			})
		end,
	},

	-- dashboard to setup the startup page
	{
		'nvimdev/dashboard-nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		
		config = function()
			require('dashboard').setup ({
				config = {
					-- config the header
					-- header = {
					-- 	'',
					-- 	'                  -`                   ',
					-- 	'                 .o+`                  ',
					-- 	'                `ooo/                  ',
					-- 	'               `+oooo:                 ',
					-- 	'              `+oooooo:                ',
					-- 	'              -+oooooo+:               ',
					-- 	'            `/:-:++oooo+:              ',
					-- 	'           `/++++/+++++++:             ',
					-- 	'          `/++++++++++++++:            ',
					-- 	'         `/+++ooooooooooooo/`          ',
					-- 	'        ./ooosssso++osssssso+`         ',
					-- 	'       .oossssso-````/ossssss+`        ',
					-- 	'      -osssssso.      :ssssssso.       ',
					-- 	'     :osssssss/        osssso+++.      ',
					-- 	'    /ossssssss/        +ssssooo/-:     ',
					-- 	'  `/ossssso+/:-        -:/+osssso+-    ',
					-- 	'  `+sso+:-`                 `.-/+oso:  ',
					-- 	' `++:.                           `-/+/ ',
					-- 	' .`                                 `/ ',
					-- 	'',
					-- },

					-- config the center section in doom theme
					-- center = {
          --   { action = "Telescope find_files",      desc = " Search file",       icon = " ", key = "s" },
					-- }

					-- the week day headers
					week_header = {
						enable = true  --boolean use a week header
						-- concat = true  --concat string after time string line
						-- append = true --table append after time string line
					},
					disable_move = false,  -- boolean default is false disable move key
					shortcut = {
						{ desc = '󰊳 Update Plugins', group = '@property', action = 'Lazy update', key = 'u' },
						{
							-- icon = ' ',
							icon = ' ',
							icon_hl = '@variable',
							desc = 'Files',
							group = 'Label',
							action = 'Telescope find_files',
							key = 'f',
						},
						{ desc = "󰒲 Lazy Manager", group = "@property", action = "Lazy", key = "l" }
					},
				},
				hide = {
					statusline = false,    -- hide statusline default is true
					tabline = false,       -- hide the tabline
					winbar = false,        -- hide winbar
				},

			})
		end,
	}
}


