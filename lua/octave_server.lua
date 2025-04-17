local lspconfig = require("lspconfig")
local lspconfig_config = require("lspconfig.configs")
-- mlang
if not lspconfig_config.mlang then
	local mlang_server = "/home/blake/.config/nvim/lua/plugins/octave_server.lua"
	lspconfig_config.mlang = {
		default_config = {
			name = "mlang",
			cmd = { "node", mlang_server, "--stdio" },
			filetypes = { "matlab", "octave", "m" },
			root_dir = function()
				return vim.fn.getcwd()
			end,
			settings = {
				settings = {
					maxNumberOfProblems = 1000,
				},
			},
		},
	}
end
print("octave_server")
