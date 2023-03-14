return {
  "williamboman/mason-lspconfig.nvim",
  opts = {
    ensure_installed = {
      "html",
      "cssls",
      -- "cssmodules_ls",
      "tailwindcss",
      "emmet_ls",
      "tsserver",
      "denols",
      "astro",
      "prismals",
      "stylelint_lsp",
      "svelte",
      "rust_analyzer",
      "lua_ls",
      -- "marksman",
      "jsonls",
      "vimls",
    },
    automatic_installation = true,
  },
}
