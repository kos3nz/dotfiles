-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

-- autocommand that reloads neovim and install/updates/removes plugins
-- whenever you save this file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- add list of plugins to install
return packer.startup(function(use)
  -- package manager
  use("wbthomason/packer.nvim")

  -- many nvim plugins depends on these plugins
  use("nvim-lua/plenary.nvim") -- lua functions that many plugins use
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in neovim

  -- preferred colorscheme
  use("bluz71/vim-nightfly-guicolors")
  use({ "catppuccin/nvim", as = "catppuccin" })
  use("EdenEast/nightfox.nvim")

  -- maximizes and restores current window
  use("szw/vim-maximizer")

  -- essential plugins
  use("tpope/vim-surround") -- add, delete, change surroundings
  use("vim-scripts/ReplaceWithRegister") -- replace with register contents using motion

  -- performance
  use("lewis6991/impatient.nvim") -- speed up start-up time with creating cache

  -- commenting
  use("numToStr/Comment.nvim") -- comment with 'gc' command
  use("JoosepAlviste/nvim-ts-context-commentstring") -- setting the commentstring based on the cursor location (via treesitter)

  -- hightlight and search for todo comments
  use("folke/todo-comments.nvim")

  -- file explorer
  use("nvim-tree/nvim-tree.lua")

  -- icons
  use("kyazdani42/nvim-web-devicons")

  -- bufferline
  use({ "romgrk/barbar.nvim", wants = "nvim-web-devicons" })

  -- status line
  use("nvim-lualine/lualine.nvim")

  -- keymaps
  use("folke/which-key.nvim")

  -- fuzzy finding w/ telescope
  use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  -- use("nvim-telescope/telescope-media-files.nvim") -- preview images, pdf, video, and fonts

  -- cmp
  use("hrsh7th/nvim-cmp") -- completion plugin
  use("hrsh7th/cmp-buffer") -- source for text in buffer
  use("hrsh7th/cmp-path") -- source for file system paths
  use("saadparwaiz1/cmp_luasnip") -- for snippet completion
  use("hrsh7th/cmp-nvim-lsp") -- for language server completion
  use("hrsh7th/cmp-vsnip") -- source for VScode(LSP)'s snippet
  use("onsails/lspkind.nvim") -- vs-code like icons for cmp

  -- snippets
  use("L3MON4D3/LuaSnip") -- snippet engine
  use("rafamadriz/friendly-snippets") -- useful snippets

  -- managing & installing lsp and null-ls servers
  use("williamboman/mason.nvim") -- in charge of managing lsp servers, linters & formatters
  use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
  use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

  -- configuring lsp servers
  use("neovim/nvim-lspconfig") -- easily configure language servers
  use({ "glepnir/lspsaga.nvim", branch = "main" }) -- enhanced lsp uis
  use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)

  -- formatting & linting
  use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters

  -- treesitter configuration
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })
  use("nvim-treesitter/playground") -- useful for Abstruct Syntax Tree
  -- use("p00f/nvim-ts-rainbow")

  -- auto closing
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
  use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

  -- git integration
  use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side

  -- terminal integration
  use("akinsho/toggleterm.nvim")

  -- highlighting other uses of the word under the cursor
  use("RRethy/vim-illuminate")

  -- highlight color in tailwindcss classname
  use("princejoogie/tailwind-highlight.nvim")

  --------------------------------------------------------------------
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  --------------------------------------------------------------------
  if packer_bootstrap then
    require("packer").sync()
  end
end)
