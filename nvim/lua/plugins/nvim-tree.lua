return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")
    nvimtree.setup({
      view = {
        width = 35,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
      },
      git = {
        ignore = false,
      },
    })

    vim.api.nvim_set_keymap("n", "<C-n>", "<cmd>NvimTreeToggle<CR>", {desc = "Toggle file explorer"})
  end
}
