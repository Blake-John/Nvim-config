require("configs.options")
require("configs.keymaps")
require("configs.autocmds")
-- require("plugins.statusline")
require("plugins.sl")
require("plugins.lsp")
require("plugins.utils")
require("plugins.colorscheme")
require("plugins.edit")
require("plugins.floatterm")
require("plugins.task")

-- 检测是否在 Neovide 中运行
if vim.g.neovide then
	print("current is in neovide")
	vim.o.background = "dark"
else
	-- 普通终端配置
	require("plugins.animate")
end
