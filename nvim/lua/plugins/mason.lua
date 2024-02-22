return {
	"williamboman/mason.nvim",
	event = "VeryLazy",
	dependencies = { "williamboman/mason-lspconfig" },
	config = function ()
		require ("mason").setup ()
	end,
}

