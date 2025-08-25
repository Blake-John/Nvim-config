return {
    -- NOTE: Bash
    {
        "mason-org/mason-lspconfig.nvim",
        ft = "sh",
        cmd = "LspInstall",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed or {}, { "bashls" } or {})
            vim.list_extend(opts.automatic_enable or {}, { "bashls" } or {})
        end,
        -- config = function(_, opts)
        --     require("mason-lspconfig").setup(opts)
        -- end
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed or {}, { "shfmt" } or {})
        end
    },
    -- NOTE: Fish
    {
        "mason-org/mason-lspconfig.nvim",
        ft = "fish",
        cmd = "LspInstall",
        dependencies = {
            "mason-org/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed or {}, { "fish_lsp" } or {})
            vim.list_extend(opts.automatic_enable or {}, { "fish_lsp" } or {})
        end,
        -- config = function(_, opts)
        --     require("mason-lspconfig").setup(opts)
        -- end
    },
}
