return {
  {
    "williamboman/mason.nvim",
    opts = {
      ui = {
        width = 0.8,
        height = 0.8,
        border = "rounded",

        icons = {
          package_installed = "",
          package_pending = "󰅐",
          package_uninstalled = "",
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
          uninstall_package = "x",
          -- Keymap to cancel a package installation
          cancel_installation = "<C-c>",
          -- Keymap to apply language filter
          apply_language_filter = "<C-f>",
          -- Keymap to toggle viewing package installation log
          toggle_package_install_log = "<CR>",
          -- Keymap to toggle the help view
          toggle_help = "?",
        },
      },
    },
  },

  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "emmet_ls",
        "vtsls",
        "denols",
        "astro",
        -- "svelte-language-server",
        -- "vuels",
        "cssls",
        -- "cssmodules-ls",
        "tailwindcss",
        "prismals",
        "lua_ls",
        "jsonls",
        "vimls",
        "shopify_theme_ls",
        -- "glslls",
        -- "gopls",
        -- "rust_analyzer",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local keys = require("lazyvim.plugins.lsp.keymaps").get()
      -- disable a keymap
      keys[#keys + 1] = { "K", false }
      keys[#keys + 1] = { "<c-k>", false, mode = "i" }

      -- add a keymap
      -- keys[#keys + 1] = { "gh", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" }
      keys[#keys + 1] = { "gh", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Hover" }
      keys[#keys + 1] = { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" }

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

      opts.diagnostics = {
        float = {
          focused = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      }

      local signs = {
        Error = "",
        Warn = "",
        Hint = "",
        Information = "",
      }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(function(_, result, ctx, config)
        config = config or {}
        config.focus_id = ctx.method
        if not (result and result.contents) then
          return
        end
        local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
        markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
        if vim.tbl_isempty(markdown_lines) then
          return
        end
        return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
      end, { border = "rounded", wrap = false })
    end,
  },
}
