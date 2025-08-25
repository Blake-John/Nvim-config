return {
    "nvim-treesitter/nvim-treesitter",
    event = "BufReadPre",
    build = ":TSUpdate",
    opts = {
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "gs",
                node_incremental = "<CR>",
                scope_incremental = "<C-CR>",
                node_decremental = "<BS>",
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
