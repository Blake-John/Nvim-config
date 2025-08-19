return {
  {
    "mason-org/mason.nvim",
    lazy = true,
    opts = {
      ui = {
        border = "rounded",
      },
      ensure_installed = {
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      diagnostics = {
        float = { border = "rounded" },
      },
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      presets = {
        lsp_doc_border = true,
      },
    },
  },
}
