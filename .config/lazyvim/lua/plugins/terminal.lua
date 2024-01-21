return {
  {
    "akinsho/toggleterm.nvim",
    keys = {
      {
        "<c-\\>",
        "<cmd>ToggleTerm direction=float<cr>",
        desc = "Toggle floating terminal",
        mode = { "n", "t" },
      },
    },
    opts = {
      size = 10,
      open_mapping = [[<F7>]],
      shading_factor = 2,
      direction = "float",
      float_opts = {
        border = "curved",
        highlights = { border = "Normal", background = "Normal" },
      },
    },
  },
}
