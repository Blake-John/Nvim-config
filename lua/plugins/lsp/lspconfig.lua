return {
    {
        "mason-org/mason-lspconfig.nvim",
        ft = "lua",
        cmd = "LspInstall",
        opts = {
            ensure_installed = {
                "lua_ls",
            },
            automatic_enable = {
                "lua_ls",
            },
        },
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        config = function(_, opts)
            require("mason-lspconfig").setup(opts)
        end,
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        lazy = true,
        dependencies = {
            "mason-org/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "stylua",
            },
            run_on_start = true,
            start_delay = 0
        },
        config = function(_, opts)
            require("mason-tool-installer").setup(opts)
        end,
    },
}
