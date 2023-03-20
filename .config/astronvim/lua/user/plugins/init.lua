-- https://github.com/folke/lazy.nvim#-migration-guide

return {
  ----- Disables -----
  --------------------

  { "p00f/nvim-ts-rainbow", enabled = false },
  { "max397574/better-escape.nvim", enabled = false },
  { "stevearc/aerial.nvim", enabled = false },
  { "mrjones2014/smart-splits.nvim", enabled = false },

  ----- Colorscheme -----
  -----------------------

  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
      })
    end,
  },

  {
    "olimorris/onedarkpro.nvim",
    priority = 1000, -- Ensure it loads first
    config = function()
      require("onedarkpro").setup({
        options = {
          transparency = true,
        },
      })
    end,
  },

  ----- Cmp -----
  ---------------

  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require("plugins.configs.luasnip")(plugin, opts) -- include the default astronvim config that calls the setup call
      require("luasnip.loaders.from_vscode").lazy_load({ paths = { "~/.config/snippets" } }) -- load snippets paths
    end,
  },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    -- optionally, override the default options:
    config = function()
      require("tailwindcss-colorizer-cmp").setup({
        color_square_width = 2,
      })
    end,
  },

  ----- Lsp -----
  ---------------

  { "jose-elias-alvarez/typescript.nvim" },

  { "sigmasd/deno-nvim" },

  { "simrat39/rust-tools.nvim" },

  { "mattn/emmet-vim", event = "User AstroFile" },

  -- {
  --   "mrshmllow/document-color.nvim",
  --   config = function()
  --     require("document-color").setup({
  --       mode = "single", -- "background" | "foreground" | "single"
  --     })
  --   end,
  -- },

  -- {
  --   "ThePrimeagen/refactoring.nvim",
  --   dependencies = {
  --     { "nvim-lua/plenary.nvim" },
  --     { "nvim-treesitter/nvim-treesitter" },
  --   },
  --   -- config = {
  --   --   require("user.plugins.refactoring"),
  --   -- },
  -- },

  ----- Telescope -----
  ---------------------

  -- {
  --     "nvim-telescope/telescope-file-browser.nvim",
  --     dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  -- },

  ----- Syntax Highlighting ----
  ------------------------------

  { "nvim-treesitter/playground", cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" } },

  { "MaxMEllon/vim-jsx-pretty", event = "User AstroFile" },




  ----- Enhancement -----
  -----------------------

  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("todo-comments").setup()
    end,
    event = "User AstroFile",
  },

  {
    "folke/trouble.nvim", -- A pretty diagnostics, references, telescope results, quickfix and location list to help you solve all the trouble your code is causing.
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup()
    end,
  },

  { "MattesGroeger/vim-bookmarks", event = "User AstroFile" },

  ----- Motion & Edit -----
  -------------------------

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup()
    end,
    event = "User AstroFile",
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup()
    end,
    event = "User AstroFile",
  },

  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
    event = "User AstroFile",
  },

  { "mg979/vim-visual-multi", event = "User AstroFile" },

  { "zhaosheng-pan/vim-im-select", event = "User AstroFile" },

  {
    "johmsalas/text-case.nvim",
    config = function()
      require("textcase").setup()
    end,
    event = "User AstroFile",
  },

  { "bkad/CamelCaseMotion", event = "User AstroFile" },

  { "wellle/targets.vim", event = "User AstroFile" },

  { "vim-scripts/ReplaceWithRegister", event = "User AstroFile" },

  { "justinmk/vim-sneak", event = "User AstroFile" },

  { "tpope/vim-repeat", event = "User AstroFile" },

  -- { "andymass/vim-matchup", event = "User AstroFile" },

  ----- Misc -----
  ----------------

  { "szw/vim-maximizer", cmd = "MaximizerToggle" },

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
    event = "User AstroFile",
  },

  ----- Git -----
  ---------------

  {
    "akinsho/git-conflict.nvim",
    version = "*",
    config = function()
      require("git-conflict").setup()
    end,
    event = "User AstroGitFile",
  },

  {
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    event = "User AstroGitFile",
  },
}
