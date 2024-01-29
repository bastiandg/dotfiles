return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-buffer", -- source for text in buffer
    "hrsh7th/cmp-path", -- source for file system paths
  },
  config = function()
    local cmp = require("cmp")
    -- loads vscode style snippets from installed plugins (e.g. friendly-snippets)
    --require("luasnip.loaders.from_vscode").lazy_load()
    cmp.setup({
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ['<S-Tab>'] = cmp.mapping.select_prev_item(), -- Shift+TAB to go to the Previous Suggested item
        ['<Tab>'] = cmp.mapping.select_next_item(), -- Tab to go to the next suggestion
        --['<C-Space>'] = cmp.mapping.select_next_item(), -- Tab to go to the next suggestion
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer" }, -- text within current buffer
        { name = "path" }, -- file system paths
      }),
    })
  end,
}
