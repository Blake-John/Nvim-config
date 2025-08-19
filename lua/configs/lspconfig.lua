require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls", "clangd", "basedpyright" }
vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers

vim.lsp.inlay_hint.enable(true)
