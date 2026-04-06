if false then
	return {
		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"MunifTanjim/nui.nvim",
				"nvim-tree/nvim-web-devicons", -- optional, but recommended
			},
			lazy = false, -- neo-tree will lazily load itself
		},
	}
else
	return {
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			local HEIGHT_RATIO = 0.6
			local WIDTH_RATIO = 0.4
			local function open_win_config_func()
				local screen_w = vim.opt.columns:get()
				local screen_h = vim.opt.lines:get()
				local window_w = screen_w * WIDTH_RATIO
				local window_h = screen_h * HEIGHT_RATIO
				local window_w_int = math.floor(window_w)
				local window_h_int = math.floor(window_h)
				local center_x = (screen_w - window_w) / 2
				local center_y = ((vim.opt.lines:get() - window_h) / 2)
				return {
					border = "double",
					relative = "editor",
					row = center_y,
					col = center_x,
					width = window_w_int,
					height = window_h_int,
				}
			end

			require("nvim-tree").setup({
				view = {
					float = {
						enable = false,
						open_win_config = open_win_config_func(),
					},
					signcolumn = "no",
					cursorline = false,
				},
				update_focused_file = {
					enable = true, -- 开启聚焦当前文件功能
					update_root = false, -- 是否同步根目录（按需开启）
					ignore_list = {},
				},
				actions = {
					open_file = {
						quit_on_open = true,
					},
				},
				renderer = {
					indent_markers = {
						enable = true,
					},
					icons = {
						show = {
							hidden = true,
						},
						git_placement = "after",
						symlink_arrow = "󱦰",
						glyphs = {
							folder = {
								-- arrow_closed = "󱦰",
								-- arrow_open = "󱦳",
								arrow_closed = "",
								arrow_open = "",
							},
							default = "󱓻",
							symlink = "󱓻",
							bookmark = "",
							modified = "",
							hidden = "󱙝",
							git = {
								-- unstaged = "×",
								unstaged = " ",
								unmerged = "󰧾",
								ignored = "∅",
								deleted = " ",
								renamed = "»",
								staged = " ",
								untracked = "?",
							},
						},
						diagnostics_placement = "after",
						bookmarks_placement = "after",
					},
				},
				diagnostics = {
					enable = true,
				},
				filters = {
					git_ignored = true,
				},
			})
		end,
	}
end
