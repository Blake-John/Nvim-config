return {
	-- the plugin for cmake project
	"Civitasv/cmake-tools.nvim",
	event = "VeryLazy",
	keys = {
		{ "CG", "<cmd>CMakeGenerate<CR>", desc = "Configure" },
		{ "CB", "<cmd>CMakeBuild<CR>", desc = "Build" },
		{ "CR", "<cmd>CMakeRun<CR>", desc = "Run" },
		{ "CC", "<cmd>CMakeClean<CR>", desc = "Clean" },
		{ "CD", "<cmd>CMakeDebug<CR>", desc = "Debug" },
		{ "CS", "<cmd>CMakeSettings<CR>", desc = "Settings" },
	},

	config = function()
		require("cmake-tools").setup {
			cmake_regenerate_on_save = false, -- auto generate when save CMakeLists.txt
			cmake_build_options = {
				"-j10",
			},
			cmake_build_directory = "build/",
		}
	end,
}
