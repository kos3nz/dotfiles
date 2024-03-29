return {
  -- control auto formatting on save
  format_on_save = {
    enabled = true, -- enable or disable format on save globally
    allow_filetypes = { -- enable format on save for specified filetypes only
      -- "go",
    },
    ignore_filetypes = { -- disable format on save for specified filetypes
      -- "python",
    },
  },
  disabled = { -- disable formatting capabilities for the listed language servers
    "jsonls",
    "lua_ls",
    "tsserver",
    -- "denols",
    -- "rust_analyzer",
  },
  timeout_ms = 2000,
  -- filter = function(client) -- fully override the default formatting function
  --   -- only enable null-ls for javascript files
  --   if vim.bo.filetype == "javascript" then
  --     return client.name == "null-ls"
  --   end
  --
  --   -- enable all other clients
  --   return true
  -- end
}
