-- Default config
-- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/stylelint_lsp.lua
--
-- Default root files
--   '.stylelintrc',
--   '.stylelintrc.cjs',
--   '.stylelintrc.js',
--   '.stylelintrc.json',
--   '.stylelintrc.yaml',
--   '.stylelintrc.yml',
--   'stylelint.config.cjs',
--   'stylelint.config.js',

-- Settings
-- https://github.com/bmatcuk/coc-stylelintplus
--
-- stylelintplus.autoFixOnFormat (default false) - automatically apply fixes in response to format requests.
-- stylelintplus.autoFixOnSave (default false) - automatically apply fixes on save.
-- stylelintplus.config (default null) - stylelint config to use.
-- stylelintplus.configFile (default null) - path to stylelint config file.
-- stylelintplus.configOverrides (default null) - stylelint config overrides.
-- stylelintplus.cssInJs (default false) - Run stylelint on javascript/typescript files.
-- stylelintplus.enable (default true) - if false, disable linting and auto-formatting.
-- stylelintplus.filetypes (default see below) - Filetypes that coc-stylelintplus will lint.
-- stylelintplus.validateOnSave (default false) - lint on save.
-- stylelintplus.validateOnType (default true) - lint after changes.

return {
  filetypes = {
    -- "html",
    "css",
    "less",
    "scss",
    -- "astro",
    -- "vue",
    -- "svelte",
  },
  settings = {
    stylelintplus = {
      autoFixOnFormat = false, -- Prettierでフォーマット後にstylelintでフォーマットしない
    },
  },
}
