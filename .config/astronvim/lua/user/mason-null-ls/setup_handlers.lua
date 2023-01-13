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
          or utils.root_has_file(".prettierrc.js")
      end,
    }))
  end,

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

  markdownlint = function()
    require("null-ls").register(require("null-ls").builtins.diagnostics.markdownlint)
    require("null-ls").register(require("null-ls").builtins.formatting.markdownlint.with({
      condition = function(utils)
        if -- if any of these files are exist, stop formatting with markdownlint
          utils.root_has_file("package.json")
          or utils.root_has_file(".prettierrc")
          or utils.root_has_file(".prettierrc.json")
          or utils.root_has_file(".prettierrc.js")
        then
          return false
        end

        return true
      end,
    }))
  end,
}
