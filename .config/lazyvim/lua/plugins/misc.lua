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
        easing = "linear", -- Easing functions: "linear", "quadratic", "cubic", "quatic", "quintic", "circular", "sine"
        pre_hook = nil, -- Function to run before the scrolling animation starts
        post_hook = nil, -- Function to run after the scrolling animation ends
        performance_mode = false, -- Performance mode that turns off syntax highlighting while scrolling for slower machines or files with heavy regex syntax highlighting.
        ignored_events = { -- Events ignored while scrolling
          "WinScrolled",
          "CursorMoved",
        },
      })

      local neoscroll = require("neoscroll")
      local keymap = {
        ["<C-u>"] = function()
          neoscroll.ctrl_u({ duration = 50 })
        end,
        ["<C-d>"] = function()
          neoscroll.ctrl_d({ duration = 50 })
        end,
        ["<C-b>"] = function()
          neoscroll.ctrl_b({ duration = 100 })
        end,
        ["<C-f>"] = function()
          neoscroll.ctrl_f({ duration = 100 })
        end,
        ["zt"] = function()
          neoscroll.zt({ half_win_duration = 25 })
        end,
        ["zz"] = function()
          neoscroll.zz({ half_win_duration = 25 })
        end,
        ["zb"] = function()
          neoscroll.zb({ half_win_duration = 25 })
        end,
      }
      local modes = { "n", "v", "x" }
      for key, func in pairs(keymap) do
        vim.keymap.set(modes, key, func)
      end
    end,
    event = { "BufReadPre", "BufNewFile" },
  },
}
