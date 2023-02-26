-- use mason-lspconfig to configure LSP installations
-- overrides `require("mason-lspconfig").setup(...)`
return {
  -- list of servers for mason to install
  ensure_installed = {
    "html",
    "cssls",
    "cssmodules_ls",
    "tailwindcss",
    "emmet_ls",
    "tsserver",
    "denols",
    "astro",
    "prismals",
    "stylelint_lsp",
    "svelte",
    "rust_analyzer",
    "sumneko_lua",
    -- "marksman",
    "jsonls",
    "vimls",
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true,
}
