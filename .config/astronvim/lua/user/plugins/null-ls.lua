return function(config)
  -- overrides `require("null-ls").setup(config)`
  -- config variable is the default configuration table for the setup function call
  local status_ok, null_ls = pcall(require, "null-ls")
  if not status_ok then
    return
  end

  -- for conciseness
  local formatting = null_ls.builtins.formatting -- to setup formatters
  local diagnostics = null_ls.builtins.diagnostics -- to setup linters

  -- Check supported formatters and linters
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
  -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
  config.sources = {
    -- Set a formatter
    formatting.stylua,
    formatting.prettierd.with({
      filetypes = {
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "less",
        "markdown",
        "scss",
        "typescript",
        "typescriptreact",
        "yaml",
        "toml",
      },
    }),
    diagnostics.eslint_d.with({
      diagnostics_format = "[eslint] #{m}\n(#{c})",
    }),
    diagnostics.markdownlint, -- markdown linter
    -- 		null_ls.builtins.diagnostics.cspell.with({
    -- 			diagnostics_postprocess = function(diagnostic)
    -- 				-- レベルをWARNに変更（デフォルトはERROR）
    -- 				diagnostic.severity = vim.diagnostic.severity["WARN"]
    -- 			end,
    -- 			condition = function()
    -- 				-- cspellが実行できるときのみ有効
    -- 				return vim.fn.executable("cspell") > 0
    -- 			end,
    -- 		}),
  }
  return config -- return final config table
end
