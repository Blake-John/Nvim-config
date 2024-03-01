return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	keys = {
		{ "gD", vim.lsp.buf.declaration, desc = "Go to Declaration" },
		{ "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
		{ "K", vim.lsp.buf.hover, desc = "Hover" },
		-- { "<C-k>", vim.lsp.buf.signature_help, desc = "Signature Help" },
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
		require ("lspconfig").clangd.setup {}
		require ("lspconfig").dockerls.setup {}
	end,
}
