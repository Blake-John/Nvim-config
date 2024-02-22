-- this file is to config the nvim ui to be more convenient to operate

return {
	
	-- the colorscheme of the nvim
	{
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme tokyonight-night]])
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
		-- config = function ()
		-- 	require ("image").setup ()
		-- end,
	},


	-- the tabs bar of the buffers
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		event = "InsertEnter",

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
			event = "InsertEnter",
			config = function ()
				require ("mini.animate").setup ()
			end,
		},

		-- add the indent highlight
		{
			"echasnovski/mini.indentscope",
			event = "InsertEnter",
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

		-- the plugin to deal with buffer
		-- {
		-- 	'echasnovski/mini.bufremove',
		-- 	version = '*',
		-- 	config = function ()
		-- 		require ("mini.bufremove").setup ()
		-- 	end,
		-- }
	},

	-- add the winbar to show the struct
	{
		"fgheng/winbar.nvim",
		event = "InsertEnter",
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


