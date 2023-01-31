-- easily add or disable built in mappings added during LSP attaching
return {
  n = {
    -- ["<leader>lf"] = false -- disable formatting keymap
    -- gi = function()
    --   require("telescope.builtin").lsp_implementations()
    -- end,
    -- gr = function()
    --   require("telescope.builtin").lsp_references()
    -- end,
    -- gd = function()
    --   require("telescope.builtin").lsp_definitions()
    -- end,

    gT = false,

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

    K = false,

    -- symbols-outline
    ["<leader>lS"] = { "<cmd>SymbolsOutline<cr>", desc = "Toggle outline" },

    -- twoslash-queries
    ["<leader>lq"] = { "<cmd>InspectTwoslashQueries<cr>" },
  },
}
