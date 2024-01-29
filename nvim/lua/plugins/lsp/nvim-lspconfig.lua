return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require("lspconfig")
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    -- used to enable autocompletion (assign to every lsp server config)
    local capabilities = cmp_nvim_lsp.default_capabilities()
    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }
    local on_attach = function(bufnr)
      opts.buffer = bufnr
      opts.desc = "Smart rename"
      keymap.set("n", "<leader>r", vim.lsp.buf.rename, opts)
    end


    lspconfig["pylsp"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        pylsp = {
          plugins = {
            pycodestyle = {
              ignore = {"E501"},
              maxLineLength = 160
            }
          }
        }
      }
    })

    lspconfig["lua_ls"].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = { -- custom settings for lua
        Lua = {
          -- make the language server recognize "vim" global
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            -- make language server aware of runtime files
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end
}
