return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    -- PERF: we don't need this lualine require madness 🤷
    local lualine_require = require("lualine_require")
    lualine_require.require = require

    local icons = LazyVim.config.icons

    vim.o.laststatus = vim.g.lualine_laststatus

    local mocha = require("catppuccin.palettes").get_palette("mocha")
    local theme = {
      normal = {
        a = { fg = mocha.blue, gui = "bold" },
        b = { fg = mocha.teal },
        c = { fg = mocha.text },
        y = { fg = mocha.blue },
        z = { fg = mocha.blue },
      },
      insert = {
        a = { fg = mocha.green, gui = "bold" },
        y = { fg = mocha.green },
        z = { fg = mocha.green },
      },
      visual = {
        a = { fg = mocha.mauve, gui = "bold" },
        y = { fg = mocha.mauve },
        z = { fg = mocha.mauve },
      },
      replace = {
        a = { fg = mocha.maroon, gui = "bold" },
        y = { fg = mocha.maroon },
        z = { fg = mocha.maroon },
      },
      command = {
        a = { fg = mocha.yellow, gui = "bold" },
        y = { fg = mocha.yellow },
        z = { fg = mocha.yellow },
      },
      inactive = {
        a = { fg = mocha.overlay0, gui = "bold" },
        y = { fg = mocha.overlay0 },
        z = { fg = mocha.overlay0 },
      },
    }

    local opts = {
      options = {
        theme = theme, -- "auto" to use the default theme, use 'theme' variable for customization
        globalstatus = vim.o.laststatus == 3,
        disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
      },
      sections = {
        lualine_a = { { "mode" } },
        lualine_b = { "branch" },

        lualine_c = {
          LazyVim.lualine.root_dir(),
          {
            "diagnostics",
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          { LazyVim.lualine.pretty_path() },
        },
        lualine_x = {
          {
            function()
              return require("noice").api.status.command.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = function()
              return LazyVim.ui.fg("Statement")
            end,
          },
          {
            function()
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = function()
              return LazyVim.ui.fg("Constant")
            end,
          },
          {
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = function()
              return LazyVim.ui.fg("Debug")
            end,
          },
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = function()
              return LazyVim.ui.fg("Special")
            end,
          },
          -- LazyVim.lualine.cmp_source("codeium"),
          {
            "diff",
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { "progress", padding = { left = 2, right = 1 } },
        },
        lualine_z = {
          { "location", padding = { left = 1, right = 2 } },
        },
      },
      extensions = { "neo-tree", "lazy" },
    }

    -- do not add trouble symbols if aerial is enabled
    -- And allow it to be overriden for some buffer types (see autocmds)
    if vim.g.trouble_lualine and LazyVim.has("trouble.nvim") then
      local trouble = require("trouble")
      local symbols = trouble.statusline({
        mode = "symbols",
        groups = {},
        title = false,
        filter = { range = true },
        format = "{kind_icon}{symbol.name:Normal}",
        hl_group = "lualine_c_normal",
      })
      table.insert(opts.sections.lualine_c, {
        symbols and symbols.get,
        cond = function()
          return vim.b.trouble_lualine ~= false and symbols.has()
        end,
      })
    end

    return opts
  end,
}
