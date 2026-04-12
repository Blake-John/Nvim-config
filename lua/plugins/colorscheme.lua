vim.pack.add({
    "https://github.com/navarasu/onedark.nvim",
})

vim.cmd.packadd("onedark.nvim")

require("onedark").setup({
    style = "warm",
    highlights = {
        Comment = { fg = "#7A818E" },
        ["@lsp.type.comment"] = { fg = "#7A818E" },
        ["@comment"] = { fg = "#7A818E" },
    },
})

vim.cmd.colorscheme("onedark")
