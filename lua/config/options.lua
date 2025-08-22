-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- LazyVim auto format
vim.g.autoformat = true

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { "lsp", { ".git", "lua" }, "cwd" }

-- Optionally setup the terminal to use
-- This sets `vim.o.shell` and does some additional configuration for:
-- * pwsh
-- * powershell
-- LazyVim.terminal.setup("pwsh")

-- Set LSP servers to be ignored when used with `util.root.detectors.lsp`
-- for detecting the LSP root
vim.g.root_lsp_ignore = { "copilot" }

-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Show the current document symbols location from Trouble in lualine
-- You can disable this for a buffer by setting `vim.b.trouble_lualine = false`
-- vim.g.trouble_lualine = true

local opt = vim.opt

opt.autowrite = true -- Enable auto write
-- only set clipboard if not in ssh, to make sure the OSC 52
-- integration works automatically. Requires Neovim >= 0.10.0
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 -- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.fillchars = {
	foldopen = "",
	foldclose = "",
	fold = " ",
	foldsep = " ",
	diff = "╱",
	eob = " ",
}
opt.foldlevel = 99 -- Open all code folds by default (high level means more folds are open)
opt.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true -- Ignore case
opt.inccommand = "nosplit" -- preview incremental substitute
opt.jumpoptions = "view"
opt.laststatus = 3 -- global statusline
opt.linebreak = true -- Wrap lines at convenient points
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.pumblend = 10 -- Popup menu transparency (0-100, where 0 is opaque and 100 is fully transparent)
opt.pumheight = 10 -- Maximum number of entries displayed in the popup menu
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.ruler = false -- Disable the default ruler, show the cursor status
opt.scrolloff = 10 -- Lines of context
opt.sidescrolloff = 10 -- Columns of context
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" } -- Session options: save buffers, current directory, tab pages, window sizes, help windows, global variables, skip runtime path, and folds
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Shorten messages: suppress written/readonly messages, intro message, completion menu messages, and indent scanning messages
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en", "cjk" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.termguicolors = true -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = "block" -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.tabstop = 4 -- Number of spaces tabs count for
opt.shiftround = true -- Round indent
opt.shiftwidth = 4 -- Size of an indent
opt.expandtab = true -- Use spaces instead of tabs

vim.o.winborder = "rounded" -- set the window border to be "rounded"
vim.o.cmdheight = 0 -- hide the original status line
opt.showmode = false -- Dont show mode since we have a statusline
opt.showcmd = false -- hide the cmdline

vim.o.guifont = "CaskaydiaMono Nerd Font:h12"

if vim.fn.has("nvim-0.10") == 1 then
	opt.smoothscroll = true
	opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
	opt.foldmethod = "expr"
	opt.foldtext = ""
else
	opt.foldmethod = "indent"
	opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

vim.ui.input = function(opts, on_confirm)
	require("snacks.input")(opts, on_confirm)
end
