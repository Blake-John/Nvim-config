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
        spacing = 4,
        source = "if_many",
        prefix = "●",
        -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
        -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
        -- prefix = "icons",
    },
})
-- inlay_hint
vim.lsp.inlay_hint.enable(true)

vim.lsp.config("basedpyright", {
    settings = {
        analysis = {
            -- 类型检查强度
            typeCheckingMode = "basic", -- off / basic / standard / strict / recommended
            -- 诊断范围
            diagnosticMode = "openFilesOnly", -- openFilesOnly / workspace
            -- 忽略目录
            exclude = { "**/node_modules/**", "**/.venv/**" },
            -- 单行诊断级别覆盖
            diagnosticSeverityOverrides = {
                reportUnusedImport = "warning",
                reportCallIssue = "none",
            },
            -- Inlay hints（内联提示）
            inlayHints = {
                variableTypes = true,
                callArgumentNames = true,
                functionReturnTypes = true,
                genericTypes = false,
            },
            -- 其他常用开关
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            autoImportCompletions = true,
            disableOrganizeImports = false, -- 与 ruff 冲突时设 true
        },
    },
})
