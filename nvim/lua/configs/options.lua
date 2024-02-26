-- This file is automatically loaded by plugins.core
vim.g.mapleader = " "					-- the leader-key
vim.g.maplocalleader = " "		-- the local leader-key

local opt = vim.opt
-- opt.winbar = "%=%m %f"
opt.autowrite = true 														-- Enable autowrite
opt.clipboard = "unnamedplus" 									-- Sync with system clipboard
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2 														-- Hide * markup for bold and italic, but not markers with substitutions
opt.confirm = true 															-- Confirm to save changes before exiting modified buffer
opt.cursorline = true 													-- Enable highlighting of the current line
opt.expandtab = false 													-- Use spaces instead of tabs
opt.formatoptions = "jcroqlnt" 									-- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true 													-- Ignore case
opt.inccommand = "nosplit" 											-- preview incremental substitute
opt.laststatus = 3 															-- global statusline
opt.list = true 																-- Show some invisible characters (tabs...
opt.mouse = "a" 																-- Enable mouse mode
opt.number = true 															-- Print line number
opt.pumblend = 10 															-- Popup blend
opt.pumheight = 10 															-- Maximum number of entries in a popup
opt.relativenumber = true 											-- Relative line numbers
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true 													-- Round indent
opt.shiftwidth = 2 															-- Size of an indent
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = true 														-- show the editor mode
opt.sidescrolloff = 8 													-- Columns of context
opt.signcolumn = "yes" 													-- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true 														-- Don't ignore case with capitals
opt.smartindent = true 													-- Insert indents automatically
opt.spell = false 															-- Disable the spell check
opt.spelllang = { "en", "cjk" }
opt.splitbelow = true 													-- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true 													-- Put new windows right of current
opt.tabstop = 2 																-- Number of spaces tabs count for
opt.termguicolors = true 												-- True color support
opt.timeoutlen = 300 														-- the timeout len of pressing two keys
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 														-- Save swap file and trigger CursorHold
opt.virtualedit = "block" 											-- Allow cursor to move where there is no text in visual block mode
opt.wildmode = "longest:full,full" 							-- Command-line completion mode
opt.winminwidth = 5 														-- Minimum window width
opt.wrap = true 																-- the config of line wrap

opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

if vim.fn.has("nvim-0.10") == 1 then
  opt.smoothscroll = true
end

-- Folding
vim.opt.foldlevel = 99
vim.opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"

-- HACK: causes freezes on <= 0.9, so only enable on >= 0.10 for now
if vim.fn.has("nvim-0.10") == 1 then
  vim.opt.foldmethod = "expr"
  vim.opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
else
  vim.opt.foldmethod = "indent"
end

vim.o.formatexpr = "v:lua.require'lazyvim.util'.format.formatexpr()"

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0


-- -- the style of the cmp
-- -- gray
-- vim.api.nvim_set_hl(0, 'CmpItemAbbrDeprecated', { bg='NONE', strikethrough=true, fg='#808080' })
-- -- blue
-- vim.api.nvim_set_hl(0, 'CmpItemAbbrMatch', { bg='NONE', fg='#569CD6' })
-- vim.api.nvim_set_hl(0, 'CmpItemAbbrMatchFuzzy', { link='CmpIntemAbbrMatch' })
-- -- light blue
-- vim.api.nvim_set_hl(0, 'CmpItemKindVariable', { bg='NONE', fg='#9CDCFE' })
-- vim.api.nvim_set_hl(0, 'CmpItemKindInterface', { link='CmpItemKindVariable' })
-- vim.api.nvim_set_hl(0, 'CmpItemKindText', { link='CmpItemKindVariable' })
-- -- pink
-- vim.api.nvim_set_hl(0, 'CmpItemKindFunction', { bg='NONE', fg='#C586C0' })
-- vim.api.nvim_set_hl(0, 'CmpItemKindMethod', { link='CmpItemKindFunction' })
-- -- front
-- vim.api.nvim_set_hl(0, 'CmpItemKindKeyword', { bg='NONE', fg='#D4D4D4' })
-- vim.api.nvim_set_hl(0, 'CmpItemKindProperty', { link='CmpItemKindKeyword' })
-- vim.api.nvim_set_hl(0, 'CmpItemKindUnit', { link='CmpItemKindKeyword' })


-- DAP settings
local dap_breakpoint_color = {
	breakpointtext = {
		ctermbg = 0,
		bg = "#31353f",
	},
	breakpoint = {
		ctermbg=0,
		-- fg='#993939',
		fg = '#f20c00',
		bg='#31353f',
	},
	logpoing = {
		ctermbg=0,
		fg='#61afef',
		bg='#31353f',
	},
	stopped = {
		ctermbg=0,
		fg='#98c379',
		-- bg='#31353f'
		bg = '#4F522C',
	},
	stoppedtext = {
		ctermbg = 0,
		bg = "#4F522C",
	}
}

vim.api.nvim_set_hl(0, 'DapBreakpoint', dap_breakpoint_color.breakpoint)
vim.api.nvim_set_hl(0, 'DapBreakpointText', dap_breakpoint_color.breakpointtext)
vim.api.nvim_set_hl(0, 'DapLogPoint', dap_breakpoint_color.logpoing)
vim.api.nvim_set_hl(0, 'DapStopped', dap_breakpoint_color.stopped)
vim.api.nvim_set_hl(0, 'DapStoppedText', dap_breakpoint_color.stoppedtext)

-- 输入unicode的方法：ctrl + v + u 再输入unicode码
-- 可在https://www.nerdfonts.com/cheat-sheet查询想要的字符
local dap_breakpoint = {
    error = {
        text = "",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpointText",
        numhl = "DapBreakpoint",
    },
    condition = {
        text = '',
        texthl = 'DapBreakpoint',
        linehl = 'DapBreakpointText',
        numhl = 'DapBreakpoint',
    },
    rejected = {
        text = "",
        texthl = "DapBreakpoint",
        linehl = "DapBreakpointText",
        numhl = "DapBreakpoint",
    },
    logpoint = {
        text = '',
        texthl = 'DapLogPoint',
        linehl = 'DapLogPoint',
        numhl = 'DapLogPoint',
    },
    stopped = {
        -- text = '',
				text = '',
        texthl = 'DapStopped',
        linehl = 'DapStoppedText',
        numhl = 'DapStopped',
    },
}
 
vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
vim.fn.sign_define('DapBreakpointCondition', dap_breakpoint.condition)
vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)
vim.fn.sign_define('DapLogPoint', dap_breakpoint.logpoint)
vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)


-- if you don't want to download the lspkind plugin, here are the local icon settings
-- local kind_icons = {
--   Text = "",
--   Method = "󰆧",
--   Function = "󰊕",
--   Constructor = "",
--   Field = "󰇽",
--   Variable = "󰂡",
--   Class = "󰠱",
--   Interface = "",
--   Module = "",
--   Property = "󰜢",
--   Unit = "",
--   Value = "󰎠",
--   Enum = "",
--   Keyword = "󰌋",
--   Snippet = "",
--   Color = "󰏘",
--   File = "󰈙",
--   Reference = "",
--   Folder = "󰉋",
--   EnumMember = "",
--   Constant = "󰏿",
--   Struct = "",
--   Event = "",
--   Operator = "󰆕",
--   TypeParameter = "󰅲",
-- }
