return {
	-- {
  -- 	"ray-x/lsp_signature.nvim",
  -- 	event = "VeryLazy",
  -- 	config = function()
	-- 		require("lsp_signature").setup({
	-- 			bind = true, -- This is mandatory, otherwise border config won't get registered.
	-- 	    handler_opts = {
  --   		  border = "rounded"
	-- 			}
	-- 		}) 
	-- 	end,
	-- },

	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		dependencies = {
			{
				"ray-x/lsp_signature.nvim",
				-- event = "InsertEnter",
				event = "BufRead",
				config = function() 
					require ("lsp_signature").setup ()
				end,
				-- config = function ()
				-- 	require ("lsp_signature").setup ()
				-- end,
			}
		},
		keys = {
			{ "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
			{ "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help" },
			{ "gr", "<cmd>Telescope lsp_references<CR>", desc = "Go to Reference" },
		},

		config = function ()
			-- set the border of the lspwindow
			vim.lsp.handlers["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			})
			vim.lsp.handlers["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
			})

			-- setup the lsp server
			-- require ("lspconfig").pyre.setup {}
			require ("lspconfig").pyright.setup {}
			require ("lspconfig").cmake.setup {}
			require ("lspconfig").clangd.setup {
				cmd = {
				"clangd",
				-- 	"--background-index",
				-- 	"--clang-tidy",
				"--header-insertion=never",
				-- 	"--completion-style=detailed",
				-- 	"--function-arg-placeholders",
				-- 	"--fallback-style=llvm",
				},
				init_options = {
					usePlaceholders = false,
					completeUnimported = false,
					clangdFileStatus = true,
				},
			}
			require ("lspconfig").dockerls.setup {}
		end,
	},
}
