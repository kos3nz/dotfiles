-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormattingOnSave", {})

-- configure null_ls
null_ls.setup({
  -- setup formatters & linters
  sources = {
    --  to disable file types use
    --  "formatting.prettier.with({disabled_filetypes: {}})" (see null-ls docs)
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
      },
    }), -- js/ts formatter
    formatting.stylua, -- lua formatter
    null_ls.builtins.diagnostics.eslint_d.with({
      diagnostics_format = "[eslint] #{m}\n(#{c})",
      condition = function(utils)
        return utils.root_has_file("package.json")
          or utils.root_has_file(".eslintrc.json")
          or utils.root_has_file(".eslintrc.js")
      end,
    }),
    diagnostics.markdownlint, -- markdown linter
    -- null_ls.builtins.diagnostics.cspell.with({
    --   diagnostics_postprocess = function(diagnostic)
    --     -- レベルをWARNに変更（デフォルトはERROR）
    --     diagnostic.severity = vim.diagnostic.severity["WARN"]
    --   end,
    --   condition = function()
    --     -- cspellが実行できるときのみ有効
    --     return vim.fn.executable("cspell") > 0
    --   end,
    -- }),
  },

  -- configure format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      -- format on save
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
