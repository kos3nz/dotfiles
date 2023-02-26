return {
  prettierd = function()
    require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with({
      filetypes = {
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
        -- "json",
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
          or utils.root_has_file("prettier.config.cjs")
      end,
    }))
  end,

  eslint_d = function()
    require("null-ls").register(require("null-ls").builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file(".eslintrc.json")
          or utils.root_has_file(".eslintrc.yaml")
          or utils.root_has_file(".eslintrc.yml")
          or utils.root_has_file(".eslintrc.js")
          or utils.root_has_file(".eslintrc.cjs") -- when running ESLint in JavaScript packages that specify "type":"module" in their package.json.
      end,
    }))
  end,

  markdownlint = function()
    require("null-ls").register(require("null-ls").builtins.diagnostics.markdownlint)
    require("null-ls").register(require("null-ls").builtins.formatting.markdownlint.with({
      condition = function(utils)
        if -- if any of these files are exist, stop formatting with markdownlint
          utils.root_has_file("package.json")
          or utils.root_has_file(".prettierrc")
          or utils.root_has_file(".prettierrc.json")
          or utils.root_has_file(".prettierrc.json5")
          or utils.root_has_file(".prettierrc.yaml")
          or utils.root_has_file(".prettierrc.yml")
          or utils.root_has_file(".prettierrc.js")
          or utils.root_has_file(".prettierrc.cjs")
          or utils.root_has_file("prettier.config.js")
          or utils.root_has_file("prettier.config.cjs")
        then
          return false
        end

        return true
      end,
    }))
  end,

  -- stylelint_lsp = function()
  -- require("null-ls").register(require("null-ls").builtins.diagnostics.stylelint)
  -- end,
}
