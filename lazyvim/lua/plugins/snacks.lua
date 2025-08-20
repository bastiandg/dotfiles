return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        hidden = true, -- for hidden files
        ignored = false, -- for .gitignore files
        sources = {
          files = {
            hidden = true, -- for hidden files
            ignored = false, -- for .gitignore files
          },
        },
      },
    },
  },
}
