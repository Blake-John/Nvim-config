vim.pack.add({
	"https://github.com/karb94/neoscroll.nvim",
	"https://github.com/sphamba/smear-cursor.nvim",
})

require("neoscroll").setup()
require("smear_cursor").setup({
	stiffness = 0.5,
	trailing_stiffness = 0.5,
	matrix_pixel_threshold = 0.5,
})
