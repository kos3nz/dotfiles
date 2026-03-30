return {
  -- window maximizer
  {
    "szw/vim-maximizer",
    event = "VeryLazy",
    keys = {
      {
        "<c-w>m",
        "<cmd>MaximizerToggle<cr>",
        desc = "Maximize window",
      },
      {
        "<leader>m",
        "<cmd>MaximizerToggle<cr>",
        desc = "Maximize window",
      },
    },
  },

}
