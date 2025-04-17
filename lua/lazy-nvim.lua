-- print ("load lazy.lua")

require ("lazy").setup ({
	spec = {{ import = "plugins" }},
	default = { lazy = true },
	ui = {
		-- border = "single"
		border = "rounded"
	}
})
