return {
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
    opts = {
      flavour = "mocha",
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
      styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
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
      },
      color_overrides = {},
      custom_highlights = function(colors)
        -- https://catppuccin.com/palette
        return {
          CursorLineNr = {
            fg = colors.blue,
          },
          MiniIndentscopeSymbol = {
            fg = colors.blue,
          },
          -- treesitter
          TreesitterContext = {
            fg = colors.blue,
          },
          TreesitterContextLineNumberBottom = {
            fg = colors.blue,
          },
          -- nvim-cmp
          CmpItemAbbr = { fg = colors.overlay2 },
          CmpItemAbbrMatch = { fg = colors.blue },
          CmpItemAbbrMatchFuzzy = { fg = colors.teal },

          -- textDocument/hover
          RenderMarkdownCode = { bg = colors.crust },
        }
      end,
      integrations = {
        aerial = true,
        alpha = true,
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
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
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
