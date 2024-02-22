-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- configure the plugins
require ("lazy").setup ({
  spec = {
    -- configure my plugins from the "plugins" path
    { import = "plugins" },
  },
  
  default = {
    -- the the plugins lazy loaded by default
    lazy = true,
    -- require the plugins to be the newest commit
    version = false,
  },

  checker = { enabled = true }, -- automatically check for plugins updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
      },
    },
  },
})
