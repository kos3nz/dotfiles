return {
  -- For prettierd:
  prettierd = function()
    require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with({
      filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
        "toml",
        -- "markdown",
      },
      condition = function(utils)
        return utils.root_has_file("package.json")
          or utils.root_has_file(".prettierrc")
          or utils.root_has_file(".prettierrc.json")
          or utils.root_has_file(".prettierrc.js")
      end,
    }))
  end,
  -- For eslint_d:
  eslint_d = function()
    require("null-ls").register(require("null-ls").builtins.diagnostics.eslint_d.with({
      condition = function(utils)
        return utils.root_has_file(".eslintrc")
          or utils.root_has_file(".eslintrc.json")
          or utils.root_has_file(".eslintrc.js")
          or utils.root_has_file(".eslintrc.cjs")
      end,
    }))
  end,
}
