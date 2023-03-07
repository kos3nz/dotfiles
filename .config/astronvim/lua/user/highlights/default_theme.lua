return function(highlights) -- a function that returns a new table of colors to set
  local C = require("default_theme.colors")

  highlights.Normal = { fg = C.fg, bg = C.bg }

  -- New approach instead of diagnostic_style
  highlights.DiagnosticError.italic = true
  highlights.DiagnosticHint.italic = true
  highlights.DiagnosticInfo.italic = true
  highlights.DiagnosticWarn.italic = true

  return highlights
end
