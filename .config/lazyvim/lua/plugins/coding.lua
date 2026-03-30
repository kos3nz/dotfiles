return {
  -- auto completion
  {
    "saghen/blink.cmp",
    version = "*",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-d>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      },
      completion = {
        menu = {
          border = "rounded",
          draw = {
            treesitter = { "lsp" },
          },
        },
        documentation = {
          window = {
            border = "rounded",
          },
          auto_show = true,
          auto_show_delay_ms = 200,
        },
        ghost_text = {
          enabled = true,
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      appearance = {
        nerd_font_variant = "mono",
      },
    },
  },

  -- comments
  {
    "numToStr/Comment.nvim",
    event = "LazyFile", -- shortcut for event = { "BufReadPost", "BufWritePost", "BufNewFile" }, but defers (and re-triggers) the event to make sure the ui isn't blocked for initial rendering
    keys = {
      {
        "<c-_>",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        desc = "Toggle comment line",
        mode = { "n", "i" },
      },
      {
        "<c-_>",
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        desc = "Toggle comment line",
        mode = { "v", "x" },
      },
    },
    config = true, -- runs require('Comment').setup()
  },

  -- multi cursor
  {
    "mg979/vim-visual-multi",
    event = "LazyFile",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-g>",
        ["Find Subword Under"] = "<C-g>",
        ["Select Cursor Down"] = "<C-n>",
        ["Select Cursor Up"] = "<C-p>",
      }
    end,
  },

  -- visual star search
  {
    "nelstrom/vim-visual-star-search",
    event = "LazyFile",
  },

  -- camel case motion
  {
    "bkad/CamelCaseMotion",
    event = "VeryLazy",
    init = function()
      vim.g.camelcasemotion_key = ","
    end,
    keys = {
      {
        "w",
        "<Plug>CamelCaseMotion_w",
        mode = { "n", "v", "x" },
      },
      {
        "e",
        "<Plug>CamelCaseMotion_e",
        mode = { "n", "v", "x" },
      },
      {
        "b",
        "<Plug>CamelCaseMotion_b",
        mode = { "n", "v", "x" },
      },
      {
        "m",
        "<Plug>CamelCaseMotion_ie",
        mode = { "o" },
      },
    },
  },

  -- replace with register
  {
    "vim-scripts/ReplaceWithRegister",
    event = "LazyFile",
    keys = {
      { "<leader>r", "<Plug>ReplaceWithRegisterOperator", desc = "ReplaceWithRegisterOperator" },
      { "<leader>rr", "<Plug>ReplaceWithRegisterLine", desc = "ReplaceWithRegisterLine" },
      { "<leader>r", "<Plug>ReplaceWithRegisterVisual", desc = "ReplaceWithRegisterVisual", mode = "x" },
    },
  },
}
