vim.pack.add({
	"https://github.com/Civitasv/cmake-tools.nvim",
})

local map = vim.keymap.set
local osys = require("cmake-tools.osys")

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "c", "cpp", "cmake", "h", "hpp", "cc" },
	once = true,
	callback = function()
		vim.cmd.packadd("cmake-tools.nvim")
		require("cmake-tools").setup({
			cmake_build_directory = function()
				if osys.iswin32 then
					return "build\\${variant:buildType}"
				end
				return "build/${variant:buildType}"
			end, -- this is used to specify generate directory for cmake, allows macro expansion, can be a string or a function returning the string, relative to cwd.
		})
		map("n", "<leader>rc", ":CMakeGenerate<cr>", { desc = "Configure Project" })
		map("n", "<leader>rC", ":CMakeClean<cr>", { desc = "Clean Build" })
		map("n", "<leader>ri", ":CMakeInstall<cr>", { desc = "Install Target" })
		map("n", "<leader>rb", ":CMakeBuild<cr>", { desc = "Build Project" })
		map("n", "<leader>rr", ":CMakeRun<cr>", { desc = "Run Program" })
		map("n", "<leader>ra", ":CMakeLaunchArgs<cr>", { desc = "Run With Args" })
		map("n", "<leader>rt", ":CMakeSelectBuildType<cr>", { desc = "Select BuildType" })
		map("n", "<leader>rk", ":CMakeSelectKit<cr>", { desc = "Select Kit" })
		map("n", "<leader>rp", ":CMakeSelectBuildPreset<cr>", { desc = "Select Preset" })
	end,
})

vim.lsp.enable("clangd")
