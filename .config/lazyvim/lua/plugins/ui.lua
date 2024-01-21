return {
  -- dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
         ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
         ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
         ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
         ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
         ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
         ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
    ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"

      local opts = {
        theme = "doom",
        hide = {
          -- this is taken care of by lualine
          -- enabling this messes up the actual laststatus setting after loading a file
          statusline = false,
        },
        config = {
          header = vim.split(logo, "\n"),
        -- stylua: ignore
        center = {
          { action = "Neotree toggle",                                           desc = " File Explorer",   icon = " ", key = "e" },
          { action = "Telescope find_files hidden=true",                         desc = " Find file",       icon = "󰍉 ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New file",        icon = "󰧮 ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find text",       icon = "󱎸 ", key = "g" },
          { action = [[lua require("lazyvim.util").telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = "󰑓 ", key = "s" },
          { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = "󰆧 ", key = "x" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end

      return opts
    end,
  },

  -- Fancy Buffer Tabs
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
      { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
      { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<leader>bt", "<Cmd>enew<CR>", desc = "New file" },
      { "<leader>b1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
      { "<leader>b2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
      { "<leader>b3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
      { "<leader>b4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
      { "<leader>b5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
      { "<leader>b6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
      { "<leader>b7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
      { "<leader>b8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
      { "<leader>b9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
    },
    opts = {
      options = {
        numbers = "ordinal",
        close_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        right_mouse_command = function(n)
          require("mini.bufremove").delete(n, false)
        end,
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        diagnostics_indicator = function(_, _, diag)
          -- local icons = require("lazyvim.config").icons.diagnostics
          -- local ret = (diag.error and icons.Error .. diag.error .. " " or "")
          --   .. (diag.warning and icons.Warn .. diag.warning or "")
          local ret = (diag.error and " " .. diag.error .. " " or "")
            .. (diag.warning and " " .. diag.warning or "")
          return vim.trim(ret)
        end,
        name_formatter = function(buf) -- buf contains:
          -- name                | str        | the basename of the active file
          -- path                | str        | the full path of the active file
          -- bufnr (buffer only) | int        | the number of the active buffer
          -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
          -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
          return " " .. buf.name
        end,
        offsets = {
          {
            filetype = "neo-tree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left",
            offset_separator = true,
            separator = "│",
            padding = 0.8,
          },
        },
        separator_style = "thin",
        indicator = {
          icon = "▎", -- this should be omitted if indicator style is not 'icon'
          style = "none", -- 'icon' | 'underline' | 'none',
        },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd("BufAdd", {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },

  -- Highly experimental plugin that completely replaces the UI for messages, cmdline and the popupmenu.
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true, -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {}, -- global options for the cmdline. See section on views
        ---@type table<string, CmdlineFormat>
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          cmdline = { kind = "cmdline", pattern = "^:", icon = "󰧛 ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = "󰍉 ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = "󰍉 ", lang = "regex" },
          filter = { kind = "filter", pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { kind = "lu", pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { kind = "help", pattern = "^:%s*he?l?p?%s+", icon = "󱜻 " },
          -- input = {}, -- Used by input()
          -- lua = false, -- to disable a format, set to `false`
        },
      },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = false, -- enables the Noice messages UI
        view = "notify", -- default view for messages
        view_error = "notify", -- view for errors
        view_warn = "notify", -- view for warnings
        view_history = "messages", -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      popupmenu = {
        enabled = true, -- enables the Noice popupmenu UI
        ---@type 'nui'|'cmp'
        backend = "nui", -- backend to use to show regular cmdline completions
        ---@type NoicePopupmenuItemKind|false
        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        kind_icons = {}, -- set to `false` to disable icons
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      routes = {
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "; after #%d+" },
              { find = "; before #%d+" },
            },
          },
          view = "mini",
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = true,
      },
    },
  -- stylua: ignore
  keys = {
    { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
    { "<leader>snl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
    { "<leader>snh", function() require("noice").cmd("history") end, desc = "Noice History" },
    { "<leader>sna", function() require("noice").cmd("all") end, desc = "Noice All" },
    { "<leader>snd", function() require("noice").cmd("dismiss") end, desc = "Dismiss All" },
    { "<c-d>", function() if not require("noice.lsp").scroll(4) then return "<c-d>" end end, silent = true, expr = true, desc = "Scroll forward", mode = {"i", "n", "s"} },
    { "<c-u>", function() if not require("noice.lsp").scroll(-4) then return "<c-u>" end end, silent = true, expr = true, desc = "Scroll backward", mode = {"i", "n", "s"}},
  },
  },

  -- Icons
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      override = {
        deb = { icon = "", name = "Deb" },
        lock = { icon = "", name = "Lock" },
        mp3 = { icon = "󰸪", name = "Mp3" },
        mp4 = { icon = "", name = "Mp4" },
        out = { icon = "", name = "Out" },
        ["robots.txt"] = { icon = "󱙺", name = "Robots" },
        ttf = { icon = "󰛖", name = "TrueTypeFont" },
        rpm = { icon = "", name = "Rpm" },
        woff = { icon = "󰛖", name = "WebOpenFontFormat" },
        woff2 = { icon = "󰛖", name = "WebOpenFontFormat2" },
        xz = { icon = "", name = "Xz" },
        zip = { icon = "", name = "Zip" },
      },
      -- globally enable different highlight colors per icon (default to true)
      -- if set to false all icons will have the default icon's color
      color_icons = true,
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = false,
      -- globally enable "strict" selection of icons - icon will be looked up in
      -- different tables, first by filename, and if not found by extension; this
      -- prevents cases when file doesn't have any extension but still gets some icon
      -- because its name happened to match some extension (default to false)
      strict = true,
      -- same as `override` but specifically for overrides by filename
      -- takes effect when `strict` is true
      override_by_filename = {
        [".gitignore"] = {
          icon = "󰊢",
          color = "#6B8492", -- #6B8492, #f1502f
          name = "Gitignore",
        },
        [".stylelintrc"] = {
          icon = "",
          color = "#f0f0f0",
          name = "Stylelint",
        },
        ["tailwind.config.js"] = {
          icon = "󱏿",
          color = "#38bdf8",
          name = "TailwindCSS",
        },
        ["tailwind.config.cjs"] = {
          icon = "󱏿",
          color = "#38bdf8",
          name = "TailwindCSS",
        },
        ["tailwind.config.ts"] = {
          icon = "󱏿",
          color = "#38bdf8",
          name = "TailwindCSS",
        },
        -- ["tsconfig.json"] = {
        --   icon = "󰛦",
        --   color = "#3b82f6",
        --   name = "TypescriptJSON",
        -- },
        ["vite.config.ts"] = {
          icon = "󱐋",
          color = "#FAE05E",
          name = "Vite",
        },
        ["vitest.config.ts"] = {
          icon = "󱐋",
          color = "#FAE05E",
          name = "Vite",
        },
      },
      -- same as `override` but specifically for overrides by extension
      -- takes effect when `strict` is true
      override_by_extension = {
        ["astro"] = {
          icon = "",
          color = "#EC682C",
          name = "Astro",
        },
        ["log"] = {
          icon = "",
          color = "#81e043",
          name = "Log",
        },
        ["js"] = {
          icon = "󰌞", --  󰌞
          color = "#facc15",
          name = "Javascript",
        },
        ["cjs"] = {
          icon = "󰌞",
          color = "#facc15",
          name = "CommonJS",
        },
        ["mjs"] = {
          icon = "󰌞",
          color = "#facc15",
          name = "ESModules",
        },
        ["jsx"] = {
          icon = "", -- 󰜈,
          color = "#82D7F7",
          name = "JavascriptReact",
        },
        ["ts"] = {
          icon = "󰛦", -- ,󰛦a
          color = "#3b82f6",
          name = "Typescript",
        },
        ["tsx"] = {
          icon = "",
          color = "#82D7F7",
          name = "TypescriptReact",
        },
        ["d.ts"] = {
          icon = "󰛦", -- ,󰛦
          color = "#3baa36",
          name = "Types",
        },
        ["sh"] = {
          icon = "",
          color = "#7dd3fc",
          name = "Shell",
        },
        ["zsh"] = {
          icon = "",
          color = "#428850",
          name = "Zsh",
        },
        ["json"] = {
          icon = "󰘦", -- 󰘦  
          color = "#E0C58C",
          name = "JSON",
        },

        ["toml"] = {
          icon = "",
          color = "#EC6968",
          name = "TOML",
        },
      },
    },
  },
}
