return {
	"neovim/nvim-lspconfig",
	event = "VeryLazy",
	config = function ()
		require ("lspconfig").pyre.setup {}
		require ("lspconfig").clangd.setup {}
	end,
}
