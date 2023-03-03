return function(config)
  -- the first element of the default configuration table is the statusline
  config[1] = {
    -- set the fg/bg of the statusline
    hl = { fg = "fg", bg = "bg" },
    -- when adding the mode component, enable the mode text with padding to the left/right of it
    astronvim.status.component.mode({
      mode_text = { padding = { left = 1, right = 1 } },
      hl = { fg = "#222222", bold = true },
    }),
    -- add all the other components for the statusline
    astronvim.status.component.git_branch(),
    astronvim.status.component.file_info(
      astronvim.is_available("bufferline.nvim") and { filetype = {}, filename = false, file_modified = false } or nil
    ),
    astronvim.status.component.git_diff(),
    astronvim.status.component.diagnostics(),
    astronvim.status.component.fill(),
    astronvim.status.component.lsp(),
    astronvim.status.component.treesitter(),
    astronvim.status.component.nav(),
  }

  -- the second one is the winbar
  -- config[2] = {
  --   fallthrough = false,
  --   -- if the current buffer matches the following buftype or filetype, disable the winbar
  --   {
  --     condition = function()
  --       return astronvim.status.condition.buffer_matches({
  --         buftype = { "terminal", "prompt", "nofile", "help", "quickfix" },
  --         filetype = { "NvimTree", "neo-tree", "dashboard", "Outline", "aerial" },
  --       })
  --     end,
  --     init = function()
  --       vim.opt_local.winbar = nil
  --     end,
  --   },
  --   -- if the window is currently active, show the breadcrumbs
  --   {
  --     condition = astronvim.status.condition.is_active,
  --     astronvim.status.component.breadcrumbs({ hl = { fg = "winbar_fg", bg = "winbar_bg" } }),
  --   },
  --   -- if the window is not currently active, show the file information
  --   {
  --     astronvim.status.component.file_info({
  --       file_icon = { hl = false },
  --       hl = { fg = "winbarnc_fg", bg = "winbarnc_bg" },
  --       surround = false,
  --     }),
  --   },
  -- }

  -- disabel winbar
  config[2] = false

  -- return the final configuration table
  return config
end
