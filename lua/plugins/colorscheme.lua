return {
  -- add gruvbox
  {
    "navarasu/onedark.nvim",
    lazy = false,
    opts = {
      style = "darker",
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
