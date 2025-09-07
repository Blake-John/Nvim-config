return {
    {
        "pmizio/typescript-tools.nvim",
        ft = { "typescript", "tsx", "typescriptreact" },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
        opts = {
            tsserver_file_preferences = {
                includeInlayParameterNameHints = "all",
                includeCompletionsForModuleExports = true,
                quotePreference = "auto",
            }
        },
    },
    -- {
    --     "WhoIsSethDaniel/mason-tool-installer.nvim",
    --     opts = function(_, opts)
    --         vim.list_extend(opts.ensure_installed or {}, { "" } or {})
    --     end,
    -- },
}
