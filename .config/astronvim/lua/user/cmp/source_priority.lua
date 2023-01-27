-- CMP Source Priorities
-- modify here the priorities of default cmp sources
-- higher value == higher priority
-- The value can also be set to a boolean for disabling default sources:
-- false == disabled
-- true == 1000
return {
  nvim_lsp = 900,
  nvim_lua = 700,
  luasnip = 600,
  buffer = 500,
  path = 250,
  -- cmp_tabnine = 100,
}
