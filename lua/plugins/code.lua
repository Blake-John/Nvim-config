return {
  {
    "folke/neodev.nvim",
    event = "VeryLazy",
    dependencies = { "folke/neoconf.nvim" },
  },
  {
    {
      "nvim-treesitter/nvim-treesitter",
      event = "VeryLazy",
    },
    {
      "nvim-treesitter/nvim-treesitter-context",
      event = "VeryLazy",
    },
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
      event = "VeryLazy",
    },
  },
}
