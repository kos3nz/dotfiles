-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here

return function()
  -- vim.api.nvim_create_augroup("packer_conf", { clear = true })
  -- vim.api.nvim_create_autocmd("BufWritePost", {
  --   desc = "Sync packer after modifying plugins.lua",
  --   group = "packer_conf",
  --   pattern = "plugins.lua",
  --   command = "source <afile> | PackerSync",
  -- })

  vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches

  vim.api.nvim_create_autocmd(
    { "BufRead", "BufNewFile" },
    { pattern = { "*.txt", "*.md", "*.tex" }, command = "setlocal spell" }
  )

  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "settings.json", "keybindings.json", "**/snippets/*.json", "tsconfig.json" },
    command = "setlocal filetype=jsonc",
  })
end
