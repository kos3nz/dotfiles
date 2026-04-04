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
        a = { fg = mocha.blue, bg = mocha.surface0, gui = "bold" },
        b = { fg = mocha.teal, bg = mocha.mantle },
        c = { fg = mocha.text, bg = mocha.crust },
        x = { fg = mocha.text, bg = mocha.crust },
        y = { fg = mocha.blue, bg = mocha.mantle },
        z = { fg = mocha.blue, bg = mocha.surface0 },
      },
      insert = {
        a = { fg = mocha.green, bg = mocha.surface0, gui = "bold" },
        y = { fg = mocha.green, bg = mocha.mantle },
        z = { fg = mocha.green, bg = mocha.surface0 },
      },
      visual = {
        a = { fg = mocha.mauve, bg = mocha.surface0, gui = "bold" },
        y = { fg = mocha.mauve, bg = mocha.mantle },
        z = { fg = mocha.mauve, bg = mocha.surface0 },
      },
      replace = {
        a = { fg = mocha.maroon, bg = mocha.surface0, gui = "bold" },
        y = { fg = mocha.maroon, bg = mocha.mantle },
        z = { fg = mocha.maroon, bg = mocha.surface0 },
      },
      command = {
        a = { fg = mocha.yellow, bg = mocha.surface0, gui = "bold" },
        y = { fg = mocha.yellow, bg = mocha.mantle },
        z = { fg = mocha.yellow, bg = mocha.surface0 },
      },
      inactive = {
        a = { fg = mocha.overlay0, bg = mocha.surface0, gui = "bold" },
        y = { fg = mocha.overlay0, bg = mocha.mantle },
        z = { fg = mocha.overlay0, bg = mocha.surface0 },
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
              ---@diagnostic disable-next-line: undefined-field
              return require("noice").api.status.command.get()
            end,
            cond = function()
              ---@diagnostic disable-next-line: undefined-field
              return package.loaded["noice"] and require("noice").api.status.command.has()
            end,
            color = function()
              return { fg = Snacks.util.color("Statement") }
            end,
          },
          {
            function()
              ---@diagnostic disable-next-line: undefined-field
              return require("noice").api.status.mode.get()
            end,
            cond = function()
              ---@diagnostic disable-next-line: undefined-field
              return package.loaded["noice"] and require("noice").api.status.mode.has()
            end,
            color = function()
              return { fg = Snacks.util.color("Constant") }
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
              return { fg = Snacks.util.color("Debug") }
            end,
          },
          {
            require("lazy.status").updates,
            color = function()
              return { fg = Snacks.util.color("Special") }
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
