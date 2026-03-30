return {
  -- Disable tokyonight
  { "folke/tokyonight.nvim", enabled = false },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "mocha",
      },
      transparent_background = true,
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      no_italic = false, -- Force no italic
      no_bold = false, -- Force no bold
      no_underline = false, -- Force no underline
      styles = { -- General code styles
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {},
      },
      color_overrides = {},
      custom_highlights = function(colors)
        return {
          Normal = { bg = "none" },
          NormalNC = { bg = "none" },
          LineNr = { fg = colors.overlay1, bg = "none" },
          SignColumn = { bg = "none" },
          FoldColumn = { bg = "none" },
          CursorLineNr = { fg = colors.blue },
          MiniIndentscopeSymbol = { fg = colors.blue },
          TreesitterContext = { bg = "none" },
          TreesitterContextLineNumberBottom = { fg = colors.blue, bg = "none" },
          CmpItemAbbr = { fg = colors.overlay2 },
          CmpItemAbbrMatch = { fg = colors.blue },
          CmpItemAbbrMatchFuzzy = { fg = colors.peach },
          SnacksPickerNormal = { bg = "none" },
          SnacksPickerBorder = { bg = "none" },
          NeoTreeNormal = { bg = "none" },
          NeoTreeNormalNC = { bg = "none" },
        }
      end,
      integrations = {
        aerial = true,
        alpha = true,
        blink_cmp = true,
        cmp = true,
        dashboard = true,
        flash = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotree = true,
        noice = true,
        notify = true,
        neorg = true,
        overseer = true,
        render_markdown = true,
        rainbow_delimiters = true,
        semantic_tokens = true,
        symbols_outline = true,
        snacks = true,
        telescope = {
          enabled = false,
        },
        treesitter = true,
        treesitter_context = true,
        ts_結 = true,
        window_picker = true,
        which_key = true,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  -- {
  --   "shaunsingh/moonlight.nvim",
  -- },

  -- {
  --   "rebelot/kanagawa.nvim",
  --   opts = {
  --     compile = false, -- enable compiling the colorscheme
  --     undercurl = true, -- enable undercurls
  --     commentStyle = { italic = true },
  --     functionStyle = {},
  --     keywordStyle = { italic = true },
  --     statementStyle = { bold = true },
  --     typeStyle = {},
  --     transparent = false, -- do not set background color
  --     dimInactive = false, -- dim inactive window `:h hl-NormalNC`
  --     terminalColors = true, -- define vim.g.terminal_color_{0,17}
  --     colors = { -- add/modify theme and palette colors
  --       palette = {},
  --       theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
  --     },
  --     -- overrides = function(colors) -- add/modify highlights
  --     --   return {}
  --     -- end,
  --     theme = "wave", -- Load "wave" theme when 'background' option is not set
  --     background = { -- map the value of 'background' option to a theme
  --       dark = "wave", -- try "dragon" !
  --       light = "lotus",
  --     },
  --   },
  -- },
}
