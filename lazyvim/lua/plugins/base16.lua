return {
  {
    "RRethy/nvim-base16",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme("base16-hardcore")
      vim.api.nvim_set_hl(0, "Normal", { ctermfg = "White", ctermbg = "Black" })
      vim.api.nvim_set_hl(0, "CursorLineNr", { cterm = bold, bold = true })
    end,
  },
}
