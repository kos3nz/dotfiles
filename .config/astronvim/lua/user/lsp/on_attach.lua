local document_color_status, document_color = pcall(require, "document-color")
if not document_color_status then
  return
end

-- local twoslash_queries_status, twoslash_queries = pcall(require, "twoslash-queries")
-- if not twoslash_queries_status then
--   return
-- end

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
  lsp_keymaps(client, bufnr)

  -- if client.name == "tsserver" then
  --   twoslash_queries.attach(client, bufnr)
  -- end

  if client.name == "tailwindcss" then
    document_color.buf_attach(bufnr)
  end
end
