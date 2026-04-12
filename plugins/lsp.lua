vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
})

local function packadd(name)
    vim.cmd("packadd " .. name)
end
local map = vim.keymap.set

vim.cmd.packadd("nvim-lspconfig")

vim.lsp.enable("lua_ls")

