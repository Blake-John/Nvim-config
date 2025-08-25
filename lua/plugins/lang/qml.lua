return {
    {
        "mason-org/mason-lspconfig.nvim",
        ft = "qml",
        cmd = "LspInstall",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed or {}, { "qmlls" } or {})
            vim.list_extend(opts.automatic_enable or {}, { "qmlls" } or {})
        end,
    },
}
