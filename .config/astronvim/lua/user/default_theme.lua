-- Default theme configuration
return {
  -- Modify the color palette for the default theme
  colors = {
    fg = "#abb2bf",
    bg = "#1e222a",
  },

  -- enable or disable highlighting for extra plugins
  plugins = {
    aerial = false,
    beacon = false,
    bufferline = true,
    cmp = true,
    dashboard = true,
    highlighturl = true,
    hop = false,
    indent_blankline = true,
    lightspeed = false,
    ["neo-tree"] = true,
    notify = false,
    ["nvim-tree"] = false,
    ["nvim-web-devicons"] = true,
    rainbow = false,
    symbols_outline = false,
    telescope = true,
    treesitter = true,
    vimwiki = false,
    ["which-key"] = true,
  },
}
