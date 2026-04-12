vim.pack.add({
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/nvimdev/lspsaga.nvim",
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "https://github.com/nvim-lua/plenary.nvim",
})

local map = vim.keymap.set
local autocmd = vim.api.nvim_create_autocmd

-- =========================================================
-- nvim-lspconfig - a config sets for lsp
-- =========================================================
autocmd("BufReadPre", {
    once = true,
    callback = function()
        vim.lsp.inlay_hint.enable(true)

        vim.diagnostic.config({
            signs = {
                -- 一次性定义 4 个级别的图标
                text = {
                    [vim.diagnostic.severity.ERROR] = "󰅚",
                    [vim.diagnostic.severity.WARN] = "󰀪",
                    [vim.diagnostic.severity.HINT] = "󰌶",
                    [vim.diagnostic.severity.INFO] = "󰋽",
                },
                -- 保留 1 个字符宽度的固定列，避免整行左右抖动
                numhl = false,
            },
            underline = true,
            update_in_insert = true,
            severity_sort = true,
            virtual_text = {
                current_line = true,
                spacing = 2,
                source = "if_many",
                -- prefix = "●",
                prefix = "",
                -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
                -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
                -- prefix = "icons",
                format = function(diagnostic)
                    if diagnostic.severity == vim.diagnostic.severity.ERROR then
                        return string.format("󰅚  %s", diagnostic.message)
                    elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                        return string.format("󰀪  %s", diagnostic.message)
                    elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                        return string.format("󰋽  %s", diagnostic.message)
                    elseif diagnostic.severity == vim.diagnostic.severity.HINT then
                        return string.format("󰌶  %s", diagnostic.message)
                    end
                end,
            },
        })

        vim.lsp.enable("lua_ls")
        vim.lsp.enable("clangd")
        vim.lsp.enable("basedpyright")
        vim.lsp.enable("rust_analyzer")

        vim.cmd.packadd("nvim-lspconfig")
    end
})


-- =========================================================
-- mason - lsp, linter, formatter management
-- =========================================================
vim.api.nvim_create_user_command("Mason", function()
    vim.cmd.packadd("mason.nvim")
    require("mason").setup()
    vim.cmd("Mason")
end, {})

-- =========================================================
-- lspsaga - breadcrumbs, definition, code action ...
-- =========================================================
autocmd("BufReadPre", {
    once = true,
    callback = function()
        vim.cmd.packadd("lspsaga.nvim")
        require("lspsaga").setup({
            ui = {
                code_action = "",
            },
        })

        map("n", "<leader>o", ":Lspsaga outline<cr>", { desc = "Toggle Outline" })
        map("n", "<leader>d", ":Lspsaga peek_definition<cr>", { desc = "Peek Definition" })
    end
})

-- ===========================================================
-- treesitter - parser management
-- ===========================================================

vim.api.nvim_create_user_command("TSUpdate", function()
    vim.cmd.packadd("nvim-treesitter")
    require("nvim-treesitter").setup()
    vim.cmd("TSUpdate")
end, {})

-- ===========================================================
-- General Lsp Config
-- ===========================================================
vim.lsp.config("rust_analyzer", {
    cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        buildScripts = {
            enable = true,
        },
    },
    checkOnSave = true,
    check = { command = "clippy" },
    diagnostics = {
        enable = true,
    },
    procMacro = {
        enable = true,
    },
    inlayHints = {
        enable = true,
        -- 类型提示
        typeHints = { enable = true },
        -- 函数/方法形参名字提示
        parameterHints = { enable = true },
        -- 链式调用中间类型提示
        chainingHints = { enable = true },
        -- 闭链括号提示
        closingBraceHints = { enable = true, minLines = 0 },
        -- 生命周期提示
        lifetimeElisionHints = {
            enable = true,
            useParameterNames = true,
        },
        -- 绑定模式提示（ref / ref mut）
        bindingModeHints = { enable = true },
        -- 闭包捕获提示
        closureCaptureHints = { enable = true },
        -- 闭包返回类型提示
        closureReturnTypeHints = { enable = "always" },
        -- 闭包显示样式
        -- closureStyle = "impl_fn",
        -- 枚举判别式提示
        discriminantHints = { enable = "always" },
        -- 重借用提示 &mut -> &mut
        -- reborrowHints = { enable = "always" },
        -- 隐式 drop 提示（如离开作用域时）
        -- implicitDrops = {
        --     enable = true, -- 高亮隐式 drop 的位置
        -- },
    },
    lens = {
        enable = true,
        references = {
            adt = { enable = true },
            method = { enable = true },
        },
    },
})


-- ============================================================
-- special lsp config
-- ============================================================
require("plugins.langs.rust")
require("plugins.langs.c_cpp")
