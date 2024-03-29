-- Add highlight groups in any theme
return {
  -- BufferLineTabClose = { fg = "#1e222a", bg = "#1e222a" },
  -- BufferLineBufferSelected = { fg = "#abb2bf", bg = "#1e222a" },
  -- NormalNC = { fg = "#abb2bf", bg = "#1e222a" },
  -- WinBar = { fg = "#5c6370", bg = "#1e222a" },
  -- WinBarNC = { fg = "#5c6370", bg = "#1e222a" },
  Cursorline = { bg = "#223137" },

  Type = { fg = "#60cbd9" },

  --VS code cmp
  CmpItemKindConstructor = { fg = "#f28b25" },
  CmpItemKindUnit = { fg = "#D4D4D4" },
  CmpItemKindProperty = { fg = "#D4D4D4" },
  CmpItemKindKeyword = { fg = "#D4D4D4" },
  CmpItemKindMethod = { fg = "#C586C0" },
  CmpItemKindFunction = { fg = "#C586C0" },
  CmpItemKindColor = { fg = "#C586C0" },
  CmpItemKindText = { fg = "#9CDCFE" },
  CmpItemKindInterface = { fg = "#9CDCFE" },
  CmpItemKindVariable = { fg = "#9CDCFE" },
  CmpItemKindField = { fg = "#9CDCFE" },
  CmpItemKindValue = { fg = "#9CDCFE" },
  CmpItemKindEnum = { fg = "#9CDCFE" },
  CmpItemKindEnumMember = { fg = "#9CDCFE" },
  CmpItemKindStruct = { fg = "#9CDCFE" },
  CmpItemKindReference = { fg = "#9CDCFE" },
  CmpItemKindTypeParameter = { fg = "#9CDCFE" },
  CmpItemKindSnippet = { fg = "#D4D4D4" },
  CmpItemKindClass = { fg = "#f28b25" },
  CmpItemKindModule = { fg = "#D4D4D4" },
  CmpItemKindOperator = { fg = "#D4D4D4" },
  CmpItemKindConstant = { fg = "#D4D4D4" },
  CmpItemKindFile = { fg = "#D4D4D4" },
  CmpItemKindFolder = { fg = "#D4D4D4" },
  CmpItemKindEvent = { fg = "#D4D4D4" },
  CmpItemAbbrMatch = { fg = "#18a2fe", bold = true },
  CmpItemAbbrMatchFuzzy = { fg = "#18a2fe", bold = true },
  CmpItemMenu = { fg = "#777d86" },

  -- Symbols outline
  TSURI = { fg = "#f28b25" },
  TSConstant = { fg = "#D4D4D4" },
  TSConstructor = { fg = "#f28b25" },
  TSType = { fg = "#9CDCFE" },
  TSNamespace = { fg = "#D4D4D4" },
  TSField = { fg = "#C586C0" },
  TSFunction = { fg = "#18a2fe" },
  TSMethod = { fg = "#18a2fe" },
  TSOperator = { fg = "#D4D4D4" },
  TSParameter = { fg = "#9CDCFE" },
  TSNumber = { fg = "#D4D4D4" },
  TSString = { fg = "#9CDCFE" },
  TSBoolean = { fg = "#f28b25" },

  -- Spell
  SpellBad = { sp = "#ffbba6", undercurl = true },
  SpellCap = { sp = "#ffbba6", undercurl = true },
  SpellLocal = { sp = "#ffbba6", undercurl = true },
  SpellRare = { sp = "#ffbba6", undercurl = true },

  -- Inlay hint
  LspInlayHint = { fg = "#777d86" },

  -- Git conflict
  GitConflictCurrentLabel = { bg = "#2f7366" },
  GitConflictCurrent = { bg = "#2e5049" },
  GitConflictIncomingLabel = { bg = "#2f628e" },
  GitConflictIncoming = { bg = "#344f69" },
  GitConflictAncestorLabel = { bg = "#754a81" },
  GitConflictAncestor = { bg = "#754a81" },

  -- Twoslash queries
  -- TwoSlashQueries = { fg = "#777d86" },
}
