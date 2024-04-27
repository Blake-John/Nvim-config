return {
	{
    	"iamcco/markdown-preview.nvim",
    	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    	ft = { "markdown" },
    	build = function() vim.fn["mkdp#util#install"]() end,
		keys = {
			{"<leader>m", "<cmd>MarkdownPreview<CR>", desc = "Preview Markdown"}
		}
	},
	-- {"ellisonleao/glow.nvim", config = true, cmd = "Glow"}
}
