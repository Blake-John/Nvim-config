require ("configs.options")
require ("configs.lazy")
require ("configs.autocmds")
require ("configs.keymaps")
-- require ("plg-settings.cmake-tools")

-- vim.api.nvim_create_autocmd (
--   "User",
--   {
--     pattern = "VeryLazy",
--     callback = function ()
--       require ("configs.autocmds")
--       require ("configs.keymaps")
--     end,
--   }
-- )
-- require ("luasnip.loaders.from_vscode").lazy_load ({
-- 	path = { "~/.config/nvim/lua/plugins/my-snippets/" },
-- })
