return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make BUILD_FROM_SOURCE=true",
	keys = {
		{
			"<leader>aa",
			function()
				require("avante.api").ask()
			end,
			desc = "avante: ask",
		},
		{
			"<leader>an",
			function()
				require("avante.api").new({ new_chat = true })
			end,
			desc = "avante: new",
		},
	},
	version = false, -- Never set this value to "*"! Never!
	lazy = true,
	---@module 'avante'
	---@type avante.Config
	opts = {
		-- add any opts here
		-- for example
		provider = "openai",
		providers = {
			openai = {
				endpoint = "https://apis.iflow.cn/v1",
				model = "qwen3-coder",
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 64000,
				},
			},
			moonshot = {
				endpoint = "https://api.moonshot.ai/v1",
				model = "kimi-k2-0711-preview",
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 32768,
				},
			},
		},
		behaviour = {
			auto_suggestions = false, -- 实验阶段
			auto_set_highlight_group = true,
			auto_set_keymaps = true,
			auto_apply_diff_after_generation = false,
			support_paste_from_clipboard = false,
			minimize_diff = true, -- 是否在应用代码块时删除未更改的行
			enable_token_counting = true, -- 是否启用令牌计数。默认为 true。
			enable_cursor_planning_mode = false, -- 是否启用 Cursor 规划模式。默认为 false。
			enable_claude_text_editor_tool_mode = false, -- 是否启用 Claude 文本编辑器工具模式。
		},
		custom_tools = function()
			return { require("mcphub.extensions.avante").mcp_tool() }
		end,
		system_prompt = function()
			local hub = require("mcphub").get_hub_instance()
			return hub and hub:get_active_servers_prompt() or ""
		end,
		disabled_tools = {
			"list_files", -- Built-in file operations
			"search_files",
			"read_file",
			"create_file",
			"rename_file",
			"delete_file",
			"create_dir",
			"rename_dir",
			"delete_dir",
			"bash", -- Built-in terminal access
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		-- "echasnovski/mini.pick", -- for file_selector provider mini.pick
		-- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		-- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		-- "ibhagwan/fzf-lua", -- for file_selector provider fzf
		-- "stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		-- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"echasnovski/mini.icons",
		-- "zbirenbaum/copilot.lua", -- for providers='copilot'

		-- {
		-- 	-- support for image pasting
		-- 	"HakonHarnes/img-clip.nvim",
		-- 	event = "VeryLazy",
		-- 	opts = {
		-- 		-- recommended settings
		-- 		default = {
		-- 			embed_image_as_base64 = false,
		-- 			prompt_for_file_name = false,
		-- 			drag_and_drop = {
		-- 				insert_mode = true,
		-- 			},
		-- 			-- required for Windows users
		-- 			use_absolute_path = true,
		-- 		},
		-- 	},
		-- },
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
		{
			"ravitemer/mcphub.nvim",
			cmd = { "MCPHub" },
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			build = "bundled_build.lua", -- Bundles `mcp-hub` binary along with the neovim plugin
			opts = {
				use_bundled_binary = true, -- Use local `mcp-hub` binary
				extensions = {
					avante = {
						enabled = true,
						make_slash_commands = true, -- make /slash commands from MCP server prompts
					},
				},
			},
		},
	},
}
