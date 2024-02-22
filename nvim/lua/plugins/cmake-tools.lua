return { 
	"Civitasv/cmake-tools.nvim",
	event = "VeryLazy",
	config = function()
		require("cmake-tools").setup ({
			cmake_regenerate_on_save = false, -- auto generate when save CMakeLists.txt
			cmake_build_directory = "build/${variant:buildType}", -- this is used to specify generate directory for cmake, allows macro expansion, relative to vim.loop.cwd()
		})
	end,
}
