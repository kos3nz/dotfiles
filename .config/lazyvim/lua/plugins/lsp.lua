return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false, mode = "n" }
      keys[#keys + 1] = { "gr", false, mode = "n" }
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }
      -- add a keymap
      keys[#keys + 1] = { "gh", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" }
      keys[#keys + 1] = {
        "gl",
        function()
          vim.diagnostic.open_float()
        end,
        desc = "Hover diagnostics",
      }
      keys[#keys + 1] = {
        "[d",
        function()
          vim.diagnostic.goto_prev()
        end,
        desc = "Previous diagnostic",
      }
      keys[#keys + 1] = {
        "]d",
        function()
          vim.diagnostic.goto_next()
        end,
        desc = "Next diagnostic",
      }
    end,
    opts = {
      diagnostics = {
        float = {
          focused = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        width = 0.8,
        height = 0.8,
        border = "rounded",

        icons = {
          package_installed = "◍",
          package_pending = "◍",
          package_uninstalled = "◍",
        },

        keymaps = {
          -- Keymap to expand a package
          toggle_package_expand = "<CR>",
          -- Keymap to install the package under the current cursor position
          install_package = "i",
          -- Keymap to reinstall/update the package under the current cursor position
          update_package = "u",
          -- Keymap to check for new version for the package under the current cursor position
          check_package_version = "c",
          -- Keymap to update all installed packages
          update_all_packages = "U",
          -- Keymap to check which installed packages are outdated
          check_outdated_packages = "C",
          -- Keymap to uninstall a package
          uninstall_package = "X",
          -- Keymap to cancel a package installation
          cancel_installation = "<C-c>",
          -- Keymap to apply language filter
          apply_language_filter = "<C-f>",
          -- Keymap to toggle viewing package installation log
          toggle_package_install_log = "<CR>",
          -- Keymap to toggle the help view
          toggle_help = "g?",
        },
      },
    },
  },
  -- {
  --   "williamboman/mason-lspconfig.nvim",
  --   opts = {
  --     ensure_installed = {
  --       "html",
  --       "cssls",
  --       -- "cssmodules_ls",
  --       "tailwindcss",
  --       "emmet_ls",
  --       "tsserver",
  --       "denols",
  --       "astro",
  --       "prismals",
  --       "stylelint_lsp",
  --       "svelte",
  --       "rust_analyzer",
  --       "lua_ls",
  --       -- "marksman",
  --       "jsonls",
  --       "vimls",
  --     },
  --     automatic_installation = true,
  --   },
  -- },
}
