local alpha_button = astronvim.alpha_button

return {
  layout = {
    { type = "padding", val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) }) },
    {
      type = "text",
      val = astronvim.user_plugin_opts("header", {
        " █████  ███████ ████████ ██████   ██████",
        "██   ██ ██         ██    ██   ██ ██    ██",
        "███████ ███████    ██    ██████  ██    ██",
        "██   ██      ██    ██    ██   ██ ██    ██",
        "██   ██ ███████    ██    ██   ██  ██████",
        " ",
        "    ███    ██ ██    ██ ██ ███    ███",
        "    ████   ██ ██    ██ ██ ████  ████",
        "    ██ ██  ██ ██    ██ ██ ██ ████ ██",
        "    ██  ██ ██  ██  ██  ██ ██  ██  ██",
        "    ██   ████   ████   ██ ██      ██",
      }, false),
      opts = { position = "center", hl = "DashboardHeader" },
    },
    { type = "padding", val = 5 },
    {
      type = "group",
      val = {
        alpha_button("LDR f f", "  Find File  "),
        alpha_button("LDR f o", "  Recent  "),
        alpha_button("LDR f w", "  Find Word  "),
        alpha_button("LDR f m", "  Bookmarks  "),
        alpha_button("LDR r f", "  Find Session  "),
        alpha_button("LDR r .", "  Last Session  "),
      },
      opts = { spacing = 1 },
    },
  },
}
