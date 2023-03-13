-- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
return {
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN, max = vim.diagnostic.severity.ERROR },
  },
  underline = true,
}
