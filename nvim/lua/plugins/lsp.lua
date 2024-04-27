-- print ("load lsp.lua")

return {
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		config = function ()
			require ("lsp_signature").setup ({
				-- bind = true,
				-- handler_opts = {
				-- 	border = "rounded"
				-- }
			})
		end
	},

	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		dependencies = {
			{
				"williamboman/mason-lspconfig.nvim",
			}
		},
		config = function ()
			require ("mason").setup ({
				ui = {
					-- border = "single"
					border = "rounded"
				}
			})
			require ("mason-lspconfig").setup ()
		end,
	},

	{
		"neovim/nvim-lspconfig",
		event = "VeryLazy",
		keys = {
			{ "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
			{ "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
			{ "K", vim.lsp.buf.hover, desc = "Hover" },
			{ "<C-S-k>", vim.lsp.buf.signature_help, desc = "Signature Help" },
			{ "gr", "<cmd>Telescope lsp_references<CR>", desc = "Search References" }
		},

		config = function ()
			vim.lsp.handlers["textDocument/hover"] = vim.lsp.with (vim.lsp.handlers.hover, {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
			})
			vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with (vim.lsp.handlers.signature_help, {
				border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }
			})
			require ("neodev").setup ({})
			require ("lspconfig").pyright.setup {}
			require ("lspconfig").cmake.setup {}
			require ("lspconfig").clangd.setup {}
			require ("lspconfig").lua_ls.setup ({
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace"
						}
					}
				}
			})
		end
	}
}
