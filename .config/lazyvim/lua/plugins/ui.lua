return {
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = [[
       ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
       ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
       ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
       ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
       ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║           
       ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝           
]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "e", desc = "File Explorer",   action = ":Neotree focus" },
            { icon = " ", key = "f", desc = "Find File",       action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "r", desc = "Recent Files",    action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "w", desc = "Find Text",       action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = "󰊢 ", key = "g", desc = "Git status",      action = ":lua Snacks.picker.git_status()" },
            { icon = " ", key = "c", desc = "Config",          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", action = ':lua require("persistence").load()' },
            { icon = " ", key = "x", desc = "Lazy Extras",     action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy",            action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit",            action = ":qa" },
          },
        },
      },
      bufdelete = { enabled = true },
      rename = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      indent = { enabled = true },
      scroll = { enabled = false },
      picker = {
        enabled = true,
        ui_select = true, -- replace vim.ui.select
        formatters = {
          file = {
            filename_first = true, -- display filename before the directory
          },
        },
      },
    },
    keys = {
      -- Picker
      { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
      { "<leader>,", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
      { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>n", function() Snacks.picker.notifications() end, desc = "Notification History" },
      -- find
      { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
      { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
      { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
      { "<leader>fR", function() Snacks.picker.recent({ filter = { cwd = true } }) end, desc = "Recent (cwd)" },
      -- git
      { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
      { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gs", function() Snacks.picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() Snacks.picker.git_stash() end, desc = "Git Stash" },
      { "<leader>gd", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
      { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
      -- gh
      { "<leader>gi", function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
      { "<leader>gI", function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
      { "<leader>gp", function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
      { "<leader>gP", function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },
      -- grep
      { "<leader>fw", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
      { "<leader>sb", function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
      { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual Selection or Word", mode = { "n", "x" } },
      -- search
      { '<leader>s/', function() Snacks.picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() Snacks.picker.autocmds() end, desc = "Autocmds" },
      { "<leader>sc", function() Snacks.picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() Snacks.picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sD", function() Snacks.picker.diagnostics() end, desc = "Workspace Diagnostics" },
      { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() Snacks.picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() Snacks.picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() Snacks.picker.man() end, desc = "Man Pages" },
      { "<leader>sR", function() Snacks.picker.resume() end, desc = "Resume" },
      { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo History" },
      { "<leader>uC", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
      -- session
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Stop Session" },
      -- buffers
      {
        "<leader>bd",
        function()
          local bufs = vim.fn.getbufinfo({buflisted = true})

          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              Snacks.bufdelete()
            elseif choice == 2 then -- No
              Snacks.bufdelete({force = true})
            else
              return
            end
          else
            Snacks.bufdelete()
          end

          if not bufs[2] then
            Snacks.dashboard.open()
          end
        end,
        desc = "Delete Buffer"
      },
      {
        "<leader>bD",
        function()
          local bufs = vim.fn.getbufinfo({ buflisted = true })
          Snacks.bufdelete({force = true})
          if not bufs[2] then
            Snacks.dashboard.open()
          end
        end,
        desc = "Delete Buffer (Force)"
      },
      -- Other
  { "<leader>un", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications", },

    },
  },

  -- Fancy Buffer Tabs
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete non-pinned buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete other buffers" },
      { "<leader>bh", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete buffers to the left" },
      { "<leader>bl", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete buffers to the right" },
      { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
      { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<leader>bmp", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "<leader>bmn", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      { "[b", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
      { "]b", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
      { "[B", false },
      { "]B", false },
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
    opts = function(_, opts)
      opts.options = {
        numbers = "ordinal",
        close_command = function(n)
          Snacks.bufdelete(n)
        end,
        right_mouse_command = function(n)
          Snacks.bufdelete(n)
        end,
        diagnostics = "nvim_lsp",
        buffer_close_icon = "",
        modified_icon = "",
        left_trunc_marker = " ",
        right_trunc_marker = " ",
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
            text = "Explorer",
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
        truncate_names = false, -- whether or not tab names should be truncated
      }

      local ok, bufferline_theme = pcall(require, "catppuccin.groups.integrations.bufferline")
      if ok then
        opts.highlights = bufferline_theme.get() or bufferline_theme.get_theme()
      end
    end,
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
        desc = "Noice Picker",
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

  -- Icons
  {
    "nvim-mini/mini.icons",
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
        [".node-version"] = { glyph = "", hl = "MiniIconsGreen" },
        ["package.json"] = { glyph = "", hl = "MiniIconsGreen" },
        ["package-lock.json"] = { glyph = "", hl = "MiniIconsRed" },
        ["yarn.lock"] = { glyph = "", hl = "MiniIconsCyan" },
        [".yarnrc.yml"] = { glyph = "", hl = "MiniIconsCyan" },
        ["pnpm-lock.yaml"] = { glyph = "󰋁", hl = "MiniIconsOrange" },
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
        ["tsconfig.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.base.json"] = { glyph = "", hl = "MiniIconsAzure" },
        ["tsconfig.build.json"] = { glyph = "", hl = "MiniIconsAzure" },
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
        [".shopifyignore"] = { glyph = "", hl = "MiniIconsGrey" },
        [".theme-check.yml"] = { glyph = "", hl = "MiniIconsPurple" },
        ["translation.yml"] = { glyph = "", hl = "MiniIconsGreen" },
        ["shopify.app.toml"] = { glyph = "", hl = "MiniIconsGreen" },
        ["shopify.extension.toml"] = { glyph = "", hl = "MiniIconsGreen" },
        ["shopify.theme.toml"] = { glyph = "", hl = "MiniIconsGreen" },
        ["shopify.web.toml"] = { glyph = "", hl = "MiniIconsGreen" },
      },
      filetype = {
        dotenv = { glyph = "", hl = "MiniIconsYellow" },
      },
      extension = {
        astro = { glyph = "", hl = "MiniIconsOrange" },
        ["d.ts"] = { glyph = "󰛦", hl = "MiniIconsGreen" },
        liquid = { glyph = "", hl = "MiniIconsCyan" },
        sh = { glyph = "", hl = "MiniIconsBlue" },
        zsh = { glyph = "", hl = "MiniIconsGreen" },
      },
    },
  },
}
