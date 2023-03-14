return {
  "folke/which-key.nvim",
  opts = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 2, 0, 2, 0 }, -- extra window margin [top, right, bottom, left]
      padding = { 2, 4, 2, 4 }, -- extra window padding [top, right, bottom, left]
      winblend = 0, -- value between 0-100 0 for fully opaque and 100 for fully transparent
    },
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 8, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
    icons = {
      breadcrumb = "", -- symbol used in the command line area that shows your active key combo
      separator = "»", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
  },
}
