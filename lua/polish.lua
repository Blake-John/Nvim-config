-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.opt.shiftround = true -- Round indent
vim.opt.shiftwidth = 2 -- Size of an indent
vim.g.neovide_cursor_trail_size = 0.5
vim.g.neovide_cursor_animation_length = 0.1
vim.g.neovide_scroll_animation_length = 0.2
vim.g.neovide_remember_window_size = true
-- vim.lsp.config("matlab_ls", {
--   -- 指定服务器启动命令
--   cmd = {
--     "/home/blake/.local/share/nvim/mason/bin/matlab-language-server",
--     "--stdio",
--   },
--   -- 文件类型关联
--   filetypes = { "matlab" }, -- 仅对 .m 文件启用
--   -- 根目录识别规则
--   -- root_dir = require("lspconfig").util.root_pattern(
--   --   ".git",
--   --   "Project.toml",
--   --   "README.md" -- 根据项目结构调整
--   -- ),
--   -- 服务器设置（可选）
--   settings = {
--     MATLAB = {
--       matlabConnectionTiming = "onStart", -- 启动时连接 MATLAB 引擎
--       installPath = "/home/blake/Matlab/R2024a/", -- 需确保环境变量已设置
--       telemetry = true,
--       indexWorkspace = true,
--     },
--   },
--   single_file_support = false,
-- })
-- vim.lsp.enable "matlab_ls"

-- Add cells
vim.keymap.set("n", "<leader>ja", "<cmd>JupyterAddCellBelow<CR>", { desc = "Add Jupyter cell below" })
vim.keymap.set("n", "<leader>jA", "<cmd>JupyterAddCellAbove<CR>", { desc = "Add Jupyter cell above" })

-- Cell operations
vim.keymap.set("n", "<leader>jd", "<cmd>JupyterRemoveCell<CR>", { desc = "Remove current Jupyter cell" })
vim.keymap.set("n", "<leader>jm", "<cmd>JupyterMergeCellAbove<CR>", { desc = "Merge with cell above" })
vim.keymap.set("n", "<leader>jM", "<cmd>JupyterMergeCellBelow<CR>", { desc = "Merge with cell below" })
vim.keymap.set("n", "<leader>jt", "<cmd>JupyterConvertCellType<CR>", { desc = "Convert cell type (code/markdown)" })
vim.keymap.set("v", "<leader>jm", "<cmd>JupyterMergeVisual<CR>", { desc = "Merge selected cells" })
vim.keymap.set(
  "n",
  "<leader>jD",
  "<cmd>JupyterDeleteCell<CR>",
  { desc = "Delete cell under cursor and store in register" }
)
vim.keymap.set("n", "<leader>mi", ":MoltenInit<CR>", { silent = true, desc = "Initialize the plugin" })
vim.keymap.set("n", "<leader>ro", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "run operator selection" })
vim.keymap.set("n", "<leader>rl", ":MoltenEvaluateLine<CR>", { silent = true, desc = "evaluate line" })
vim.keymap.set("n", "<leader>rr", ":MoltenReevaluateCell<CR>", { silent = true, desc = "re-evaluate cell" })
vim.keymap.set(
  "v",
  "<leader>r",
  ":<C-u>MoltenEvaluateVisual<CR>gv",
  { silent = true, desc = "evaluate visual selection" }
)
vim.keymap.set("n", "<leader>rI", ":MoltenImagePopup<CR>", { silent = true, desc = "show the image in img viwer" })
vim.keymap.set("n", "<leader>rd", ":MoltenDelete<CR>", { silent = true, desc = "molten delete cell" })
vim.keymap.set("n", "<leader>oh", ":MoltenHideOutput<CR>", { silent = true, desc = "hide output" })
vim.keymap.set("n", "<leader>os", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "show/enter output" })

vim.keymap.set("n", "<leader>rt", ":Telescope ros2 topics_info<CR>", { silent = true, desc = "list topics" })
vim.keymap.set("n", "<leader>ret", ":!ros2 topic echo ", { silent = true, desc = "echo topics" })
vim.keymap.set("n", "<leader>rn", ":Telescope ros2 nodes<CR>", { silent = true, desc = "list nodes" })
vim.keymap.set("n", "<leader>ri", ":Telescope ros2 interfaces<CR>", { silent = true, desc = "inspect interfaces" })
vim.keymap.set("n", "<leader>rs", ":Telescope ros2 services<CR>", { silent = true, desc = "list services" })
vim.keymap.set("n", "<leader>ra", ":Telescope ros2 actions<CR>", { silent = true, desc = "list actions" })
