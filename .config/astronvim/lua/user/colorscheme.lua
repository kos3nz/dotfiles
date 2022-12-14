local colorGrp = vim.api.nvim_create_augroup("UserColors", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
  command = [[
    hi Cursorline guibg=#1b1f25
  ]],
  group = colorGrp,
})

-- Set colorscheme to use
return "catppuccin"
