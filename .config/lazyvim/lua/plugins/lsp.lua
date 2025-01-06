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
        -- "denols",
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

      opts.servers = {
        --- @deprecated -- tsserver renamed to ts_ls but not yet released, so keep this for now
        --- the proper approach is to check the nvim-lspconfig release version when it's released to determine the server name dynamically
        tsserver = {
          enabled = false,
        },
        ts_ls = {
          enabled = false,
        },
        vtsls = {
          -- explicitly add default filetypes, so that we can extend
          -- them in related extras
          filetypes = {
            "javascript",
            "javascriptreact",
            "javascript.jsx",
            "typescript",
            "typescriptreact",
            "typescript.tsx",
          },
          settings = {
            complete_function_calls = true,
            vtsls = {
              enableMoveToFileCodeAction = true,
              autoUseWorkspaceTsdk = true,
              experimental = {
                maxInlayHintLength = 30,
                completion = {
                  enableServerSideFuzzyMatch = true,
                },
              },
            },
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = {
                completeFunctionCalls = true,
              },
              inlayHints = {
                enumMemberValues = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
                parameterNames = { enabled = "literals" },
                parameterTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                variableTypes = { enabled = false },
              },
            },
          },
          keys = {
            {
              "gD",
              function()
                local params = vim.lsp.util.make_position_params()
                LazyVim.lsp.execute({
                  command = "typescript.goToSourceDefinition",
                  arguments = { params.textDocument.uri, params.position },
                  open = true,
                })
              end,
              desc = "Goto Source Definition",
            },
            {
              "gR",
              function()
                LazyVim.lsp.execute({
                  command = "typescript.findAllFileReferences",
                  arguments = { vim.uri_from_bufnr(0) },
                  open = true,
                })
              end,
              desc = "File References",
            },
            {
              "<leader>co",
              LazyVim.lsp.action["source.organizeImports"],
              desc = "Organize Imports",
            },
            {
              "<leader>cM",
              LazyVim.lsp.action["source.addMissingImports.ts"],
              desc = "Add missing imports",
            },
            {
              "<leader>cu",
              LazyVim.lsp.action["source.removeUnused.ts"],
              desc = "Remove unused imports",
            },
            {
              "<leader>cD",
              LazyVim.lsp.action["source.fixAll.ts"],
              desc = "Fix all diagnostics",
            },
            {
              "<leader>cV",
              function()
                LazyVim.lsp.execute({ command = "typescript.selectTypeScriptVersion" })
              end,
              desc = "Select TS workspace version",
            },
          },
        },

        emmet_ls = {
          filetypes = {
            "astro",
            "css",
            "eruby",
            "html",
            "htmldjango",
            "javascriptreact",
            "less",
            "pug",
            "sass",
            "scss",
            "svelte",
            "typescriptreact",
            "vue",
            "htmlangular",
            "liquid",
          },
        },
      }

      -- opts.servers = {
      --   vtsls = {
      --     settings = {
      --       typescript = {
      --         inlayHints = {
      --           enumMemberValues = { enabled = false },
      --           parameterNames = { enabled = false },
      --         },
      --       },
      --     },
      --   },
      -- emmet_ls = {
      -- filetypes = {
      --   "astro",
      --   "css",
      --   "eruby",
      --   "html",
      --   "htmldjango",
      --   "javascriptreact",
      --   "less",
      --   "pug",
      --   "sass",
      --   "scss",
      --   "svelte",
      --   "typescriptreact",
      --   "vue",
      --   "htmlangular",
      --   "liquid",
      -- },
      -- },
      -- }

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

      opts.diagnostics = {
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
            [vim.diagnostic.severity.INFO] = " ",
          },
        },
      }

      -- Add a border for ":LspInfo"
      require("lspconfig.ui.windows").default_options.border = "rounded"

      -- Add a border for LSP diagnostic popup
      vim.diagnostic.config({
        float = { border = "rounded" },
      })

      -- NOTE: Switching to noice.nvim (ui.lua: @line 214)
      --
      -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(function(_, result, ctx, config)
      --   config = config or {}
      --   config.focus_id = ctx.method
      --   if not (result and result.contents) then
      --     return
      --   end
      --   local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
      --   markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
      --   if vim.tbl_isempty(markdown_lines) then
      --     return
      --   end
      --   return vim.lsp.util.open_floating_preview(markdown_lines, "markdown", config)
      -- end, { border = "rounded", wrap = false })
    end,
  },
}
