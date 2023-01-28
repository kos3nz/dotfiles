return {
  -- enable syntax highlighting
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  -- enable indentation
  indent = { enable = false },
  -- ensure these language parsers are installed
  ensure_installed = {
    "json",
    "javascript",
    "typescript",
    "tsx",
    "yaml",
    "toml",
    "html",
    "css",
    "scss",
    "markdown",
    "svelte",
    "astro",
    "graphql",
    "prisma",
    "rust",
    "bash",
    "lua",
    "vim",
    "dockerfile",
    "gitignore",
  },

  -- Extensions
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autopairs = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
}
