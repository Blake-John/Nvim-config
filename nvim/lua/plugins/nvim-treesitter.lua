return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VeryLazy",
		config = function ()
			-- Identifier - variable name
			vim.api.nvim_set_hl(0, "@text.reference", { fg = "#2AA198" })
			vim.api.nvim_set_hl(0, "@parameter", { fg = "#2AA198" })
			vim.api.nvim_set_hl(0, "@field", { fg = "#2AA198" })
			vim.api.nvim_set_hl(0, "@property", { fg = "#2AA198" })
			vim.api.nvim_set_hl(0, "@variable", { fg = "#2AA198" })

			-- Function
			vim.api.nvim_set_hl(0, "@function", { fg = "#268BD2" })
			vim.api.nvim_set_hl(0, "@function.builtin", { fg = "#268BD2" })
			vim.api.nvim_set_hl(0, "@method", { fg = "#268BD2" })
			vim.api.nvim_set_hl(0, "@constructor", { fg = "#268BD2" })

			-- Keyword
			vim.api.nvim_set_hl(0, "@statement", {fg = "#d33682"})
			vim.api.nvim_set_hl(0, "@conditional", { fg = "#d33682" })
			vim.api.nvim_set_hl(0, "@repeat", { fg = "#d33682" })
			vim.api.nvim_set_hl(0, "@label", { fg = "#d33682" })
			vim.api.nvim_set_hl(0, "@keyword", { fg = "#d33682" })
			vim.api.nvim_set_hl(0, "@exception", { fg = "#d33682" })
			vim.api.nvim_set_hl(0, "@structure", { fg = "#2AA198" })
			vim.api.nvim_set_hl(0, "@define", { fg = "#d33682" })
			vim.api.nvim_set_hl(0, "@include", { fg = "#d33682" })

			-- special target
			vim.api.nvim_set_hl(0, "@storageclass", { fg = "#CB4B16" })
			vim.api.nvim_set_hl(0, "@constant", { fg = "#ef662c" })
			vim.api.nvim_set_hl(0, "@constant.builtin", { fg = "#ef662c" })
			-- vim.api.nvim_set_hl(0, "@operator", { fg = "#CB4B16" })

			-- Type
			vim.api.nvim_set_hl(0, "@type", { fg = "#d39f03" })
			vim.api.nvim_set_hl(0, "@type.definition", { fg = "#d39f03" })

			-- Number
			vim.api.nvim_set_hl(0, "@number", { fg = "#6C71C4" })
			vim.api.nvim_set_hl(0, "@float", { fg = "#6C71C4" })

			-- Namespace
			vim.api.nvim_set_hl(0, "@namespace", { fg = "#c86f09"})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter-context",
		event = "VeryLazy",
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "VeryLazy",
	},

	-- a plugin to inspect the treesitter highlight group
	-- but there is builtin functoin, so this is not necessary
	-- {
	-- 	"nvim-treesitter/playground",
	-- 	after = "nvim-treesitter",
	-- }
}
