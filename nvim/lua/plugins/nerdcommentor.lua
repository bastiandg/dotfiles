return {
  {
    "preservim/nerdcommenter",
    keys = {
      { "ü", ':call nerdcommenter#Comment(0, "toggle")<CR>', desc = "Comment toggle" },
      { "ü", ':call nerdcommenter#Comment(0, "toggle")<CR>', mode = "v", desc = "Comment toggle visual" },
    },
  }
}
