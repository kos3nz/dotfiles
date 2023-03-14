-- easily add or disable built in mappings added during LSP attaching
return {
  n = {
    gr = false,
    gT = false,
    K = false,

    gD = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      desc = "References of current symbol",
    },
    gh = {
      function()
        vim.lsp.buf.hover()
      end,
      desc = "Hover symbol details",
    },
    gt = {
      function()
        vim.lsp.buf.type_definition()
      end,
      desc = "Definition of current type",
    },

    -- symbols-outline
    ["<leader>lS"] = { "<cmd>SymbolsOutline<cr>", desc = "Toggle outline" },

    -- twoslash-queries
    -- ["<leader>lq"] = { "<cmd>InspectTwoslashQueries<cr>" },

    -- emmet-vim
    -- ["<C-y>d"] = { "<Plug>(emmet-balance-tag-inward)", desc = "Balance (inward)" },
    -- ["<C-y>f"] = { "<Plug>(emmet-balance-tag-outward)", desc = "Balance (outward)" },
  },
  i = {
    -- emmet-vim
    -- ["<C-y>d"] = { "<Plug>(emmet-balance-tag-inward)", desc = "Balance (inward)" },
    -- ["<C-y>f"] = { "<Plug>(emmet-balance-tag-outward)", desc = "Balance (outward)" },
  },
  v = {
    -- emmet-vim
    -- ["<C-y>d"] = { "<Plug>(emmet-balance-tag-inward)", desc = "Balance (inward)" },
    -- ["<C-y>f"] = { "<Plug>(emmet-balance-tag-outward)", desc = "Balance (outward)" },
    ["<C-y>w"] = { "<Plug>(emmet-expand-abbr)", desc = "Expand abbreviation" },
  },
}
