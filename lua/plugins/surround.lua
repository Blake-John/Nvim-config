return {
  "kylechui/nvim-surround",
  lazy = true,
  event = "LazyFile",
  opts = {},
  config = function()
    require("nvim-surround").setup({
      -- Configuration here, or leave empty to use defaults
    })
  end,
}
