-- lua/plugins/tab-autocomplete.lua
return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.keymap = {
        preset = "super-tab",
        ["<Tab>"] = { "select_and_accept" },
        ["<S-Tab>"] = { "select_prev" },
      }
    end,
  },
}
