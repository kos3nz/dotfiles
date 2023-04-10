return {
  "jay-babu/mason-null-ls.nvim",
  config = function(_, opts)
    local mason_null_ls = require("mason-null-ls")
    local null_ls = require("null-ls")

    -- As of mason-null-ls v2.0.0 "setup_handlers" function is removed (https://github.com/jay-babu/mason-null-ls.nvim/releases/tag/v2.0.0)
    mason_null_ls.setup({
      ensure_installed = {
        -- Formatter --
        "prettierd",
        "stylua",
        -- "yamlfmt",

        -- Linter --
        "eslint_d",
        "hadolint", -- linter for dockerfile
        -- "markdownlint",

        -- Diagnostics --
        -- "cspell",
      },
      automatic_installation = true,
      handlers = {
        stylua = function(source_name, methods)
          null_ls.register(null_ls.builtins.formatting.stylua)
        end,

        prettierd = function()
          null_ls.register(null_ls.builtins.formatting.prettierd.with({
            filetypes = {
              "astro",
              "css",
              "graphql",
              "html",
              "javascript",
              "javascriptreact",
              "less",
              "scss",
              "typescript",
              "typescriptreact",
              "markdown",
              "markdown.mdx",
              "json",
              "jsonc",
              -- "yaml",
              -- "toml",
            },
            condition = function(utils)
              return utils.root_has_file("package.json")
                or utils.root_has_file(".prettierrc")
                or utils.root_has_file(".prettierrc.json")
                or utils.root_has_file(".prettierrc.json5")
                or utils.root_has_file(".prettierrc.yaml")
                or utils.root_has_file(".prettierrc.yml")
                or utils.root_has_file(".prettierrc.js")
                or utils.root_has_file(".prettierrc.cjs")
                or utils.root_has_file("prettier.config.js")
            end,
          }))
        end,

        eslint_d = function()
          null_ls.register(null_ls.builtins.diagnostics.eslint_d.with({
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "vue",
              "astro",
              "markdown",
              "markdown.mdx",
            },
            condition = function(utils)
              return utils.root_has_file(".eslintrc.json")
                or utils.root_has_file(".eslintrc.yaml")
                or utils.root_has_file(".eslintrc.yml")
                or utils.root_has_file(".eslintrc.js")
                or utils.root_has_file(".eslintrc.cjs") -- when running ESLint in JavaScript packages that specify "type":"module" in their package.json.
            end,
          }))
        end,

        -- markdownlint = function()
        --   null_ls.register(null_ls.builtins.diagnostics.markdownlint.with({
        --     filetypes = { "markdown" },
        --   }))
        --   null_ls.register(null_ls.builtins.formatting.markdownlint.with({
        --     condition = function(utils)
        --       if -- if any of these files are exist, stop formatting with markdownlint
        --         utils.root_has_file("package.json")
        --         or utils.root_has_file(".prettierrc")
        --         or utils.root_has_file(".prettierrc.json")
        --         or utils.root_has_file(".prettierrc.json5")
        --         or utils.root_has_file(".prettierrc.yaml")
        --         or utils.root_has_file(".prettierrc.yml")
        --         or utils.root_has_file(".prettierrc.js")
        --         or utils.root_has_file(".prettierrc.cjs")
        --         or utils.root_has_file("prettier.config.js")
        --         or utils.root_has_file("prettier.config.cjs")
        --       then
        --         return false
        --       end
        --
        --       return true
        --     end,
        --   }))
        -- end,

        -- stylelint_lsp = function()
        -- null_ls.register(null_ls.builtins.diagnostics.stylelint)
        -- end,
      },
    })
  end,
}
