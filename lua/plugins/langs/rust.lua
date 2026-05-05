function setup_rust()
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
	local opts = {
		server = {
			on_attach = function(client, bufnr)
				-- inlay_hint
				if client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
				end
				-- CodeLens
				vim.lsp.codelens.enable(true, { bufnr = bufnr })

				local map = vim.keymap.set

				-- 核心 LSP 快捷键
				map("n", "K", function()
					vim.cmd.RustLsp({ "hover", "actions" })
				end, { desc = "Hover" })
				-- map('n', '<leader>ca', function() vim.cmd.RustLsp('codeAction') end, { desc = "Code Action" })
				map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
				map("n", "<leader>rr", function()
					vim.cmd.RustLsp({ "runnables", bang = true })
				end, { desc = "run previous runnable", buffer = bufnr })
				map("n", "<leader>rR", function()
					vim.cmd.RustLsp("runnables")
				end, { desc = "show runnables", buffer = bufnr })
				map("n", "<leader>rd", function()
					vim.cmd.RustLsp("debuggables")
				end, { desc = "show debuggables", buffer = bufnr })
				map("n", "<leader>rD", function()
					vim.cmd.RustLsp("openDocs")
				end, { desc = "open docs of current symbol", buffer = bufnr })
				map("n", "<leader>rt", function()
					vim.cmd.RustLsp("testables")
				end, { desc = "show testables", buffer = bufnr })

				map("n", "<leader>rcc", function()
					vim.cmd.RustLsp("openCargo")
				end, { desc = "open Cargo.toml", buffer = bufnr })

				map("n", "<leader>ce", function()
					vim.cmd.RustLsp({ "explainError", "current" })
				end, { desc = "explain errors", buffer = bufnr })
				map("n", "<leader>cd", function()
					vim.cmd.RustLsp({ "renderDiagnostic", "current" })
				end, { desc = "show line diagnostic", remap = true, buffer = bufnr })

				map("n", "]d", function()
					vim.cmd.RustLsp({ "renderDiagnostic", "cycle" })
				end, { desc = "next line diagnostic", remap = true, buffer = bufnr })
				map("n", "[d", function()
					vim.cmd.RustLsp({ "renderDiagnostic", "cycle_prev" })
				end, { desc = "show line diagnostic", remap = true, buffer = bufnr })

				map("n", "<S-j>", function()
					vim.cmd.RustLsp("joinLines")
				end, { desc = "smart join lines", buffer = bufnr })
			end,
		},
	}
	-- require("rustaceanvim").setup(opts)
	vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
end

setup_rust()
vim.pack.add({
	"https://github.com/Saecki/crates.nvim",
	{
		src = "https://github.com/mrcjkb/rustaceanvim",
		-- To avoid being surprised by breaking changes,
		-- I recommend you set a version range
		version = vim.version.range("^9"),
	},
})

local function setup_crates()
	local map = vim.keymap.set
	require("crates").setup()
	map("n", "<leader>rcv", function()
		require("crates").show_versions_popup()
		require("crates").show_versions_popup()
	end, { desc = "Show Version" })

	map("n", "<leader>rcf", function()
		require("crates").show_features_popup()
		require("crates").show_features_popup()
	end, { desc = "Show Features" })

	map("n", "<leader>rcu", function()
		require("crates").update_crate()
	end, { desc = "Update Crate" })

	map("n", "<leader>rcU", function()
		require("crates").update_all_crates()
	end, { desc = "Update All Crates" })
end

-- 打开 Cargo.toml 文件时 → 自动懒加载插件
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	-- 精确匹配文件名
	pattern = "Cargo.toml",
	once = true,
	callback = function()
		vim.cmd.packadd("crates.nvim") -- 例子：crates 插件
		setup_crates()
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	-- 精确匹配文件名
	once = true,
	pattern = { "rust" },
	callback = function()
		vim.cmd.packadd("crates.nvim") -- 例子：crates 插件
		setup_crates()
	end,
})
