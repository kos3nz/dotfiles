-- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
-- overrides `require("mason-null-ls").setup(...)`
return {
  -- list of formatters & linters for mason to install
  ensure_installed = {
    -- Formatter
    "prettierd",
    "stylua",
    "yamlfmt",

    -- Linter
    "eslint_d",
    "markdownlint",
    "hadolint", -- linter for dockerfile

    -- Diagnostics
    -- "cspell",
  },
  -- auto-install configured formatters & linters (with null-ls)
  automatic_installation = true,
}
