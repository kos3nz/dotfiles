return {
  -- dashboard
  {
    "nvimdev/dashboard-nvim",
    lazy = false, -- As https://github.com/nvimdev/dashboard-nvim/pull/450, dashboard-nvim shouldn't be lazy-loaded to properly handle stdin.
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
          { action = "Neotree focus",                                  desc = " File Explorer",   icon = " ", key = "e" },
          { action = 'lua LazyVim.pick()()',                           desc = " Find File",       icon = " ", key = "f" },
          { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
          { action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "w" },
          { action = "Telescope git_status",                           desc = " Git status",      icon = "󰊢 ", key = "g" },
          { action = 'lua LazyVim.pick.config_files()()',              desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = "󰑓 ", key = "s" },
          { action = "LazyExtras",                                     desc = " Lazy Extras",     icon = "󰆧 ", key = "x" },
          { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
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

      -- open dashboard after closing lazy
      if vim.o.filetype == "lazy" then
        vim.api.nvim_create_autocmd("WinClosed", {
          pattern = tostring(vim.api.nvim_get_current_win()),
          once = true,
          callback = function()
            vim.schedule(function()
              vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
            end)
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
      { "<leader>bt", "<C-o>", desc = "Reopen buffer" },
      { "<leader>bn", "<Cmd>enew<CR>", desc = "New buffer" },
      { "<leader>1", "<Cmd>BufferLineGoToBuffer 1<CR>", desc = "Go to buffer 1" },
      { "<leader>2", "<Cmd>BufferLineGoToBuffer 2<CR>", desc = "Go to buffer 2" },
      { "<leader>3", "<Cmd>BufferLineGoToBuffer 3<CR>", desc = "Go to buffer 3" },
      { "<leader>4", "<Cmd>BufferLineGoToBuffer 4<CR>", desc = "Go to buffer 4" },
      { "<leader>5", "<Cmd>BufferLineGoToBuffer 5<CR>", desc = "Go to buffer 5" },
      { "<leader>6", "<Cmd>BufferLineGoToBuffer 6<CR>", desc = "Go to buffer 6" },
      { "<leader>7", "<Cmd>BufferLineGoToBuffer 7<CR>", desc = "Go to buffer 7" },
      { "<leader>8", "<Cmd>BufferLineGoToBuffer 8<CR>", desc = "Go to buffer 8" },
      { "<leader>9", "<Cmd>BufferLineGoToBuffer 9<CR>", desc = "Go to buffer 9" },
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
        separator_style = { "", "" },
        indicator = {
          -- icon = "▎", -- this should be omitted if indicator style is not 'icon'
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

  -- Active indent guide and indent text objects. When you're browsing
  -- code, this highlights the current level of indentation, and animates
  -- the highlighting.
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "LazyFile",
    opts = {
      symbol = "│",
      options = { try_as_border = true },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
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
        -- -@type table<string, CmdlineFormat>
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          cmdline = { pattern = "^:", icon = "󰧚 ", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "󰘥 " },
          input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
          -- lua = false, -- to disable a format, set to `false`
        },
      },
      lsp = {
        hover = {
          enabled = true,
          silent = true, -- set to true to not show a message if hover is not available
        },
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      views = {
        hover = {
          border = {
            style = "rounded",
            padding = { 0, 1 },
          },
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
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and pupupmenu together
        long_message_to_split = true,
        lsp_doc_border = true, -- add a border to hover docs (disabled: @line 214) and signature help
      },
    },
    keys = {
      { "<leader>sn", "", desc = "+noice" },
      {
        "<S-Enter>",
        function()
          require("noice").redirect(vim.fn.getcmdline())
        end,
        mode = "c",
        desc = "Redirect Cmdline",
      },
      {
        "<leader>snl",
        function()
          require("noice").cmd("last")
        end,
        desc = "Noice Last Message",
      },
      {
        "<leader>snh",
        function()
          require("noice").cmd("history")
        end,
        desc = "Noice History",
      },
      {
        "<leader>sna",
        function()
          require("noice").cmd("all")
        end,
        desc = "Noice All",
      },
      {
        "<leader>snd",
        function()
          require("noice").cmd("dismiss")
        end,
        desc = "Dismiss All",
      },
      {
        "<leader>snt",
        function()
          require("noice").cmd("pick")
        end,
        desc = "Noice Picker (Telescope/FzfLua)",
      },
      {
        "<c-f>",
        function()
          if not require("noice.lsp").scroll(4) then
            return "<c-f>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll Forward",
        mode = { "i", "n", "s" },
      },
      {
        "<c-b>",
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<c-b>"
          end
        end,
        silent = true,
        expr = true,
        desc = "Scroll Backward",
        mode = { "i", "n", "s" },
      },
    },
    config = function(_, opts)
      -- HACK: noice shows messages from before it was enabled,
      -- but this is not ideal when Lazy is installing plugins,
      -- so clear the messages in this case.
      if vim.o.filetype == "lazy" then
        vim.cmd([[messages clear]])
      end
      require("noice").setup(opts)
    end,
  },

  {
    "rcarriga/nvim-notify",
    keys = {
      {
        "<leader>un",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Dismiss all Notifications",
      },
    },
    opts = {
      timeout = 3000,
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.75)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },

  -- Icons
  {
    "echasnovski/mini.icons",
    lazy = true,
    opts = {
      file = {
        -- Only the following set of highlight groups is used as icon highlight.
        -- It is recommended that they all only define colored foreground:
        -- `MiniIconsAzure`  - azure.
        -- `MiniIconsBlue`   - blue.
        -- `MiniIconsCyan`   - cyan.
        -- `MiniIconsGreen`  - green.
        -- `MiniIconsGrey`   - grey.
        -- `MiniIconsOrange` - orange.
        -- `MiniIconsPurple` - purple.
        -- `MiniIconsRed`    - red.
        -- `MiniIconsYellow` - yellow.
        [".keep"] = { glyph = "󰊢", hl = "MiniIconsGrey" },
        ["devcontainer.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["Brewfile"] = { glyph = "󱌌", hl = "MiniIconsOrange" },
        ["README.md"] = { glyph = "", hl = "MiniIconsCyan" },
        ["package-lock.json"] = { glyph = "", hl = "MiniIconsRed" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsCyan" },
        ["pnpm-lock.yaml"] = { glyph = "", hl = "MiniIconsOrange" },
        [".env"] = { glyph = "", hl = "MiniIconsGrey" },
        [".env.example"] = { glyph = "", hl = "MiniIconsGrey" },
        [".env.local"] = { glyph = "", hl = "MiniIconsGrey" },
        [".env.development"] = { glyph = "", hl = "MiniIconsGrey" },
        [".env.development.local"] = { glyph = "", hl = "MiniIconsGrey" },
        [".env.staging"] = { glyph = "", hl = "MiniIconsGrey" },
        [".env.staging.local"] = { glyph = "", hl = "MiniIconsGrey" },
        [".env.production"] = { glyph = "", hl = "MiniIconsGrey" },
        [".env.production.local"] = { glyph = "", hl = "MiniIconsGrey" },
        [".prettierrc"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierrc.json"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierrc.yml"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierrc.yaml"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierrc.js"] = { glyph = "", hl = "MiniIconsPurple" },
        ["prettier.config.js"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierrc.cjs"] = { glyph = "", hl = "MiniIconsPurple" },
        ["prettier.config.cjs"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierrc.mjs"] = { glyph = "", hl = "MiniIconsPurple" },
        ["prettier.config.mjs"] = { glyph = "", hl = "MiniIconsPurple" },
        [".prettierignore"] = { glyph = "", hl = "MiniIconsPurple" },
        [".eslintrc.json"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        [".eslintrc.yml"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        [".eslintrc.yaml"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        [".eslintrc.js"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        ["eslint.config.js"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        [".eslintrc.cjs"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        ["eslint.config.cjs"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        [".eslintrc.mjs"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        ["eslint.config.mjs"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        [".eslintignore"] = { glyph = "󰱺", hl = "MiniIconsPurple" },
        ["tailwind.config.js"] = { glyph = "󱏿", hl = "MiniIconsCyan" },
        ["tailwind.config.cjs"] = { glyph = "󱏿", hl = "MiniIconsCyan" },
        ["tailwind.config.mjs"] = { glyph = "󱏿", hl = "MiniIconsCyan" },
        ["tailwind.config.ts"] = { glyph = "󱏿", hl = "MiniIconsCyan" },
        ["vite.config.js"] = { glyph = "󱐋", hl = "MiniIconsYellow" },
        ["vite.config.ts"] = { glyph = "󱐋", hl = "MiniIconsYellow" },
        [".graphqlrc.json"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        [".graphqlrc.yml"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        [".graphqlrc.yaml"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        [".graphqlrc.js"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        ["graphql.config.js"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        ["graphql.config.ts"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        [".graphqlrc.cjs"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        ["graphql.config.cjs"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        ["graphql.config.cts"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        [".graphqlrc.mjs"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        ["graphql.config.mjs"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        ["graphql.config.mts"] = { glyph = "󰡷", hl = "MiniIconsPurple" },
        [".shopifyignore"] = { glyph = "", hl = "MiniIconsGrey" },
        [".theme-check.yml"] = { glyph = "", hl = "MiniIconsPurple" },
        ["translation.yml"] = { glyph = "", hl = "MiniIconsGreen" },
        ["shopify.app.toml"] = { glyph = "", hl = "MiniIconsGreen" },
        ["shopify.extension.toml"] = { glyph = "", hl = "MiniIconsGreen" },
        ["shopify.web.toml"] = { glyph = "", hl = "MiniIconsGreen" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
      extension = {
        astro = { glyph = "", hl = "MiniIconsOrange" },
        ["d.ts"] = { glyph = "󰛦", hl = "MiniIconsGreen" },
        sh = { glyph = "", hl = "MiniIconsBlue" },
        zsh = { glyph = "", hl = "MiniIconsGreen" },
      },
    },
  },
}
