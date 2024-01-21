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

  -- smooth scrolling
  {
    "karb94/neoscroll.nvim",
    config = function()
      require("neoscroll").setup({
        -- All these keys will be mapped to their corresponding default scrolling animation
        mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" },
        hide_cursor = true, -- Hide cursor while scrolling
        stop_eof = true, -- Stop at <EOF> when scrolling downwards
        respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
        cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
        easing_function = nil, -- Default easing function
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false, -- Disable "Performance Mode" on all buffers.
      })

      local t = {}
      -- Syntax: t[keys] = {function, {function arguments}}
      t["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "35" } }
      t["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "35" } }
      t["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "70" } }
      t["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "70" } }
      t["zt"] = { "zt", { "60" } }
      t["zz"] = { "zz", { "60" } }
      t["zb"] = { "zb", { "60" } }

      require("neoscroll.config").set_mappings(t)
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
}
