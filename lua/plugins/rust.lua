return {
  {
    "mrcjkb/rustaceanvim",
    version = "^6", -- 使用最新稳定版
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(client, bufnr)
          -- 自定义快捷键
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp "debuggables"
          end, { desc = "Rust Debug", buffer = bufnr })
          -- CodeLens
          if client.supports_method "textDocument/codeLens" then
            vim.lsp.codelens.refresh { bufnr = bufnr }
            vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave", "CursorHold" }, {
              buffer = bufnr,
              callback = function()
                vim.lsp.codelens.refresh { bufnr = bufnr }
              end,
            })
          end
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
            check = {
              command = "clippy",
            },
            diagnostics = {
              enable = true,
            },
            procMacro = {
              enable = true,
            },
            inlayHints = {
              enable = true,
              bindingModeHints = { enable = true },
              chainingHints = { enable = true },
              closingBraceHints = { enable = true },
              closureCaptureHints = { enable = true },
              closureReturnTypeHints = { enable = true },
              closureStyle = "impl_fn",
              discriminantHints = { enable = true },
              parameterHints = { enable = true },
              typeHints = { enable = true },
              renderColons = true,
              lifetimeElisionHints = {
                useParameterNames = true,
                elideLifetimes = true,
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
