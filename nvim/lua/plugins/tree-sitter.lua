return {
  {
     "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdateSync",
    config = function ()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "bash", "python", "c", "lua", "vim", "vimdoc", "html" },
          disable = { "markdown", "markdown_inline" },
          sync_install = true,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end,
  }
}
