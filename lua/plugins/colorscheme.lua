return {
	{ "typicode/bg.nvim", lazy = false },
	-- Configure LazyVim to load gruvbox
	{
		"navarasu/onedark.nvim",
        config = function()
    require('onedark').setup {
      style = 'darker'
    }
    -- Enable theme
    require('onedark').load()
  end
	},
	{
		"saghen/blink.cmp",
		event = "InsertEnter",
		dependencies = {
			"Kaiser-Yang/blink-cmp-avante",
			-- ... Other dependencies
		},
		opts = {
			sources = {
				-- Add 'avante' to the list
				default = { "avante", "lsp", "path", "snippets", "buffer" },
				providers = {
					avante = {
						module = "blink-cmp-avante",
						name = "Avante",
					},
				},
			},
			completion = {
				menu = {
					border = "rounded",
				},
				documentation = {
					window = {
						border = "rounded",
					},
				},
			},
			signature = {
				window = {
					border = "rounded",
				},
			},
		},
	},
}
