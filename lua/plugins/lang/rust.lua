-- NOTE: comment to enable rust
-- if true then return {} end
return {
	{
		"mrcjkb/rustaceanvim",
		version = "^6",
		ft = { "rust" },
		dependencies = {
			"saghen/blink.cmp",
			{
				"williamboman/mason.nvim",
				dependencies = {
					"neovim/nvim-lspconfig",
					"williamboman/mason-lspconfig.nvim",
				},
				opts = {
					ensure_installed = { "rust_analyzer" },
				},
			},
		},
		opts = {
			server = {
				on_attach = function(client, bufnr)
                    local signs = {
                        Error = "󰅚",   -- 或 ""
                        Warn  = "󰀪",   -- 或 ""
                        Hint  = "󰌶",   -- 或 "󰌵"
                        Info  = "󰋽",   -- 或 ""
                    }
                    vim.diagnostic.config({
                        signs = {
                            -- 一次性定义 4 个级别的图标
                            text = {
                                [vim.diagnostic.severity.ERROR] = '󰅚',
                                [vim.diagnostic.severity.WARN ] = '󰀪',
                                [vim.diagnostic.severity.HINT ] = '󰌶',
                                [vim.diagnostic.severity.INFO ] = '󰋽',
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
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
					-- CodeLens
					if client.supports_method("textDocument/codeLens") then
						vim.lsp.codelens.refresh({ bufnr = bufnr })
						vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
							buffer = bufnr,
							callback = function()
								vim.lsp.codelens.refresh({ bufnr = bufnr })
							end,
						})
					end
					-- keymap
					vim.keymap.set("n", "<leader>rr", "<cmd>RustLsp run<CR>", { buffer = bufnr })
					vim.keymap.set("n", "<leader>rd", "<cmd>RustLsp debug<CR>", { buffer = bufnr })
				end,
				default_settings = {
					["rust-analyzer"] = {
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
							implicitDrops = {
								enable = true, -- 高亮隐式 drop 的位置
							},
						},
						lens = {
							enable = true,
							references = {
								adt = { enable = true },
								method = { enable = true },
							},
						},
					},
				},
			},
		},
        config = function(_, opts)
            vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
        end,
	},
}
