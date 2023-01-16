local tw_highlight_status, tw_highlight = pcall(require, "tailwind-highlight")
if not tw_highlight_status then
  return
end

local twoslash_queries_status, twoslash_queries = pcall(require, "twoslash-queries")
if not twoslash_queries_status then
  return
end

-- enable keybinds only for when lsp server available
local function lsp_keymaps(client, bufnr)
  local set = vim.keymap.set
  local opts = { noremap = true, silent = true, buffer = bufnr }

  -- typescript specific keymaps
  if client.name == "tsserver" then
    set("n", "<leader>lF", ":TypescriptRenameFile<CR>", opts) -- rename file and update imports
    set("n", "<leader>lo", ":TypescriptOrganizeImports<CR>", opts) -- organize imports
    set("n", "<leader>lu", ":TypescriptRemoveUnused<CR>", opts) -- remove unused variables
  end

  -- create command "Format" to execute command "lua vim.lsp.buf.formatting()"
  -- vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({ async = true })' ]])
end

-- add to the global LSP on_attach function
return function(client, bufnr)
  -- if vim.tbl_contains({
  --   "tsserver",
  --   "sumneko_lua",
  -- }, client.name) then
  --   client.server_capabilities.documentFormattingProvider = false
  -- end

  lsp_keymaps(client, bufnr)

  if client.name == "tsserver" then
    twoslash_queries.attach(client, bufnr)
  end

  if client.name == "tailwindcss" then
    tw_highlight.setup(client, bufnr, {
      single_column = false,
      mode = "background",
      debounce = 200,
    })
  end
end
