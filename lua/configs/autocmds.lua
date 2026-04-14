local augroup = vim.api.nvim_create_augroup("UserConfig", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- hightlight yanked
autocmd("TextYankPost", {
	group = augroup,
	callback = function()
		vim.hl.on_yank()
	end,
})

-- return to last cursor position
autocmd("BufReadPost", {
	group = augroup,
	desc = "Restore last cursor position",
	callback = function()
		if vim.o.diff then -- except in diff mode
			return
		end

		local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
		local last_line = vim.api.nvim_buf_line_count(0)

		local row = last_pos[1]
		if row < 1 or row > last_line then
			return
		end

		pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
	end,
})

-- wrap, linebreak and spellcheck on markdown and text files
autocmd("FileType", {
	group = augroup,
	pattern = { "markdown", "text", "gitcommit" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.linebreak = true
		vim.opt_local.spell = true
	end,
})

-- auto load tree sitter
autocmd("FileType", {
	pattern = {
		"rust",
		"lua",
		"python",
		"javascript",
		"typescript",
		"html",
		"css",
		"json",
		"yaml",
		"toml",
		"markdown",
		"cpp",
		"c",
		"h",
		"cmake",
	},
	callback = function()
		-- 启动当前文件类型的 Tree-sitter
		local ok = pcall(vim.treesitter.start, 0)
		if not ok then
			vim.notify("Tree-sitter Parser Not Installed: " .. vim.bo.filetype, vim.log.levels.WARN)
		end
	end,
})

-- format by lsp, disable because of using conform
-- autocmd("BufWritePre", {
--     pattern = "*",
--     callback = function()
--         vim.lsp.buf.format()
--     end,
-- })
