------------------------ Custom Plugin ------------------------

return {
  ----- Disable plugins -----

  ["p00f/nvim-ts-rainbow"] = { disable = true },
  ["max397574/better-escape.nvim"] = { disable = true },

  ----- Adding plugins -----

  -- colorscheme --

  {
    "catppuccin/nvim",
    as = "catppuccin",
    config = function()
      require("catppuccin").setup({
        transparent_background = true,
      })
    end,
  },

  -- cmp --
  -- Add lazy loading for command line
  -- that triggers the loading of cmp
  ["hrsh7th/nvim-cmp"] = { keys = { ":", "/", "?" } },
  -- add more custom sources
  ["hrsh7th/cmp-cmdline"] = { after = "nvim-cmp" },

  { "hrsh7th/cmp-nvim-lua" },

  { "hrsh7th/cmp-vsnip" },

  ["tzachar/cmp-tabnine"] = {
    requires = "hrsh7th/nvim-cmp",
    after = "nvim-cmp",
    run = "./install.sh",
    config = function()
      require("cmp_tabnine.config"):setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = "..",
        ignored_file_types = {
          -- lua = true,
        },
        show_prediction_strength = false,
      })
    end,
  },

  -- lsp --

  {
    "jose-elias-alvarez/typescript.nvim",
    after = "mason-lspconfig.nvim",
    config = function()
      require("typescript").setup({
        server = astronvim.lsp.server_settings("tsserver"),
      })
    end,
  },

  {
    "sigmasd/deno-nvim",
    after = "mason-lspconfig.nvim",
    config = function()
      require("deno-nvim").setup({
        server = astronvim.lsp.server_settings("denols"),
      })
    end,
  },

  {
    "simrat39/rust-tools.nvim",
    after = "mason-lspconfig.nvim", -- make sure to load after mason-lspconfig
    config = function()
      require("rust-tools").setup({
        server = astronvim.lsp.server_settings("rust_analyzer"), -- get the server settings and built in capabilities/on_attach
      })
    end,
  },

  { "princejoogie/tailwind-highlight.nvim" },

  {
    "ThePrimeagen/refactoring.nvim",
    requires = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-treesitter/nvim-treesitter" },
    },
    -- config = {
    --   require("user.plugins.refactoring"),
    -- },
  },

  -- telescope --

  ["nvim-telescope/telescope-live-grep-args.nvim"] = {
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension("live_grep_args")
    end,
  },

  ["tom-anders/telescope-vim-bookmarks.nvim"] = {
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension("vim_bookmarks")
    end,
  },

  -- {
  --   "nvim-telescope/telescope-frecency.nvim",
  --   after = "telescope.nvim",
  --   config = function()
  --     require("telescope").load_extension("frecency")
  --   end,
  --   requires = { "kkharji/sqlite.lua" },
  -- },

  -- ["nvim-telescope/telescope-media-files.nvim"] = {
  --   after = "telescope.nvim",
  --   config = function() require("telescope").load_extension "media_files" end,
  -- },

  -- ["nvim-telescope/telescope-file-browser.nvim"] = {
  --   after = "telescope.nvim",
  --   module = "telescope._extensions.file_browser",
  --   config = function()
  --     require("telescope").load_extension("file_browser")
  --   end,
  -- },

  -- ["nvim-telescope/telescope-project.nvim"] = {
  --   after = "telescope.nvim",
  --   config = function()
  --     require("telescope").load_extension("project")
  --   end,
  -- },

  -- treesitter --
  -- { "nvim-treesitter/playground" },

  -- enhancement --

  ["folke/todo-comments.nvim"] = {
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
      })
    end,
  },

  ["folke/trouble.nvim"] = {
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
      })
    end,
  },

  { "MattesGroeger/vim-bookmarks" },

  -- motion & edit --

  {
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },
  -- { "tpope/vim-surround" },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    config = function()
      require("hop").setup({})
    end,
  },

  {
    "nacro90/numb.nvim",
    config = function()
      require("numb").setup()
    end,
  },

  { "szw/vim-maximizer" },

  { "mg979/vim-visual-multi" },

  -- { "ggandor/lightspeed.nvim" },

  -- { "andymass/vim-matchup" },

  -- { "tpope/vim-repeat" },

  -- git --

  { "tpope/vim-fugitive" },

  ["akinsho/git-conflict.nvim"] = {
    tag = "*",
    config = function()
      require("git-conflict").setup()
    end,
  },

  -- ["sindrets/diffview.nvim"] = {
  --   after = "plenary.nvim",
  --   requires = "nvim-lua/plenary.nvim",
  -- },

  -- docs --

  {
    "kkoomen/vim-doge",
    run = ":call doge#install()",
    config = function()
      require("user.plugins.vim-doge-conf").setup()
    end,
    cmd = { "DogeGenerate", "DogeCreateDocStandard" },
  },
}
