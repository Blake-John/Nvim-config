return {
	{
		-- core plugin of debug
		"mfussenegger/nvim-dap",
		event = "InsertEnter",
		keys = {
			{ "<leader>db", function () require ("dap").toggle_breakpoint () end, desc = "Toggle Breakpoint" },
			{ "<leader>dra", function () require ("dap").continue ({ before = get_args }) end, desc = "Run with Args" },
			{ "<leader>drc", function () require ("dap").run_to_cursor () end, desc = "Run to Cursor" },
			{ "<leader>dc", function () require ("dap").continue () end, desc = "Continue" },
			-- { "<leader>dg", function () require ("dap").goto_ () end, desc = "Go before Line" },
			{ "<leader>dn", function () require ("dap").step_over () end, desc = "Next (Step Over)" },
			{ "<leader>ds", function () require ("dap").step_into () end, desc = "Step Into" },
			{ "<leader>do", function () require ("dap").step_out () end, desc = "Step Out" },
		},
	},

	{
		-- for the communication of mason's dap and the nvim-dap
		"jay-babu/mason-nvim-dap.nvim",
		event = "VeryLazy",
		config = function ()
			require ("mason-nvim-dap").setup ({
				-- default settings
				handlers = {
					function(config)
						-- all sources with no handler get passed here

						-- Keep original functionality
						require('mason-nvim-dap').default_setup(config)
					end,
				}
			})
		end,
	},

	-- add the ui of the dap plugin
	{
		"rcarriga/nvim-dap-ui",
		keys = {
			{ "<leader>du", function () require ("dapui").toggle () end, desc = "DAP UI" },
		},
		config = function ()
			require ("dapui").setup ()
		end,
	},
}
