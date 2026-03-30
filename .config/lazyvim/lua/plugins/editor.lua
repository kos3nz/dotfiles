return {
  -- flash
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    keys = {
      { "r", mode = "o", false },
    },
  },

  -- Surround actions
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  -- file explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      {
        "<leader>e",
        function()
          vim.cmd("Neotree action=show toggle=true")
        end,
        desc = "Toggle Explorer",
        mode = { "n" },
      },
      {
        "<leader>o",
        function()
          if vim.bo.filetype == "neo-tree" then
            vim.cmd.wincmd("p")
          else
            vim.cmd.Neotree("focus")
          end
        end,
        desc = "Toggle Explorer Focus",
        mode = { "n" },
      },
    },
    opts = {
      close_if_last_window = true,
      source_selector = {
        winbar = false,
        -- content_layout = "center",
        -- tab_labels = {
        --   filesystem = get_icon("FolderClosed") .. " File",
        --   buffers = get_icon("DefaultFile") .. " Bufs",
        --   git_status = get_icon("Git") .. " Git",
        --   diagnostics = get_icon("Diagnostic") .. " Diagnostic",
        -- },
      },
      default_component_configs = {
        container = {
          enable_character_fade = true,
        },
        indent = {
          indent_size = 2,
          padding = 1,
          with_markers = true,
          indent_marker = "│",
          last_indent_marker = "└",
          highlight = "NeoTreeIndentMarker",
          with_expanders = true,
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
        icon = {
          folder_closed = "󰉖", --   󰉖
          folder_open = "󰷏", --     󰷏
          folder_empty = "󰜌",
          -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
          -- then these will never be used.
          default = "*",
          highlight = "NeoTreeFileIcon",
        },
        modified = {
          symbol = "",
          highlight = "NeoTreeModified",
        },
        name = {
          trailing_slash = false,
          use_git_status_colors = true,
          highlight = "NeoTreeFileName",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "", -- this can only be used in the git_status source
            renamed = "", -- this can only be used in the git_status source
            -- Status type
            untracked = "?",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },

      window = {
        position = "left",
        width = 28,
        mappings = {
          ["<space>"] = false, -- disable space until we figure out which-key disabling
          ["[b"] = false, -- "prev_source",
          ["]b"] = false, -- "next_source",
          ["oc"] = false, -- "order_by_created",
          ["od"] = false, -- "order_by_diagnostics",
          ["og"] = false, -- "order_by_git_status",
          ["om"] = false, -- "order_by_modified",
          ["on"] = false, -- "order_by_name",
          ["os"] = false, -- "order_by_size",
          ["ot"] = false, -- "order_by_type",
          ["S"] = false, -- "open_vsplit",
          ["Y"] = false, -- "copy the absolute path to clipboard",

          e = "close_window",
          l = "open",
          o = "open",
          h = "close_node",
          H = "close_all_nodes",
          ["s"] = { "show_help", nowait = false, config = { title = "Order by", prefix_key = "o" } },
          ["sc"] = { "order_by_created", nowait = false },
          ["sd"] = { "order_by_diagnostics", nowait = false },
          ["sg"] = { "order_by_git_status", nowait = false },
          ["sm"] = { "order_by_modified", nowait = false },
          ["sn"] = { "order_by_name", nowait = false },
          ["ss"] = { "order_by_size", nowait = false },
          ["st"] = { "order_by_type", nowait = false },
          ["-"] = "open_split",
          ["|"] = "open_vsplit",
          -- ["<2-LeftMouse>"] = "open",
          -- ["<cr>"] = "open",
          -- ["o"] = "open",
          -- ["S"] = "open_split",
          -- ["s"] = "open_vsplit",
          -- ["C"] = "close_node",
          -- ["<bs>"] = "navigate_up",
          -- ["R"] = "refresh",
          -- ["/"] = "fuzzy_finder",
          -- ["f"] = "filter_on_submit",
          -- ["<c-x>"] = "clear_filter",
          -- ["a"] = "add",
          -- ["d"] = "delete",
          -- ["r"] = "rename",
          -- ["y"] = "copy_to_clipboard",
          -- ["x"] = "cut_to_clipboard",
          -- ["p"] = "paste_from_clipboard",
          -- ["c"] = "copy",
          -- ["m"] = "move",
          -- ["q"] = "close_window",
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<down>"] = "move_cursor_down",
          ["<C-n>"] = "move_cursor_down",
          ["<C-j>"] = "move_cursor_down",
          ["<up>"] = "move_cursor_up",
          ["<C-p>"] = "move_cursor_up",
          ["<C-k>"] = "move_cursor_up",
        },
      },

      nesting_rules = {},

      filesystem = {
        bind_to_cwd = true,
        components = {
          name = function(config, node, state)
            local name = node.name
            if node:get_depth() == 1 then
              name = vim.fs.basename(vim.loop.cwd() or "")
            end

            local highlight = config.highlight
            if config.use_git_status_colors == nil or config.use_git_status_colors then
              local git_status = state.components.git_status({}, node, state)
              if git_status and git_status.highlight then
                highlight = git_status.highlight
              end
            end

            return {
              text = " " .. name,
              highlight = highlight,
            }
          end,
        },
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = {
            ".git",
            -- "node_modules",
          },
          hide_by_pattern = { -- uses glob style patterns
            --"*.meta",
            --"*/src/*/tsconfig.json",
          },
          always_show = { -- remains visible even if other settings would normally hide it
            --".gitignored",
          },
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            ".DS_Store",
            "thumbs.db",
          },
          never_show_by_pattern = { -- uses glob style patterns
            --".null-ls_*",
          },
        },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
        window = {
          mappings = {
            ["<bs>"] = "navigate_up",
            ["zh"] = "toggle_hidden",
            ["."] = "toggle_hidden",
            ["/"] = "fuzzy_finder",
            ["D"] = "fuzzy_finder_directory",
            ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
            ["f"] = "filter_on_submit",
            ["<c-x>"] = "clear_filter",
            ["[g"] = "prev_git_modified",
            ["]g"] = "next_git_modified",
            ["I"] = "print_me",
            ["="] = "set_root",
            [";"] = "toggle_auto_expand_width",
            ["Y"] = function(state)
              local node = state.tree:get_node()
              local path = node:get_id()
              vim.fn.setreg("+", path, "c")
            end,
          },
        },
        commands = {
          print_me = function(state)
            local node = state.tree:get_node()
            print(node.name)
          end,
        },
      },

      buffers = {
        show_unloaded = true,
        window = {
          mappings = {
            ["bd"] = "buffer_delete",
          },
        },
      },

      git_status = {
        window = {
          position = "float",
          mappings = {
            ["A"] = "git_add_all",
            ["gu"] = "git_unstage_file",
            ["ga"] = "git_add_file",
            ["gr"] = "git_revert_file",
            ["gc"] = "git_commit",
            ["gp"] = "git_push",
            ["gg"] = "git_commit_and_push",
          },
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)

      vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = "#F5E3B5" })
    end,
  },
  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("textcase").setup({})
    end,
  },
  {
    "MattesGroeger/vim-bookmarks",
    init = function()
      vim.g.bookmark_no_default_key_mappings = 1
    end,
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = {
        spelling = {
          enabled = true,
          suggestions = 5,
        },
      },
      win = {
        no_overlap = true,
        title = false,
        -- width = 1,
        height = { min = 4, max = 25 },
        border = "rounded",
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        -- zindex = 1000,
      },
      layout = {
        width = { min = 10, max = 30 }, -- min and max width of the columns
        spacing = 4, -- spacing between columns
      },
      spec = {
        mode = { "n" },
        { "<leader>w", "<cmd>w<cr>", desc = "Save" },
        { "<leader>W", "<cmd>noa w<cr>", desc = "Save Without Formatting" },
        { "g", group = "+goto" },
        { "gd", desc = "Definition" },
        { "gD", desc = "Declaration" },
        { "gr", desc = "References" },
        { "gi", desc = "Implementation" },
        { "gy", desc = "Type Definition" },
        { "gn", desc = "Rename" },
        { "gs", group = "+surround" },
        { "]", group = "+next" },
        { "[", group = "+prev" },
        { "<leader><tab>", group = "+tabs" },
        { "<leader>b", group = "+buffer" },
        { "<leader>c", group = "+code" },
        { "<leader>f", group = "+file/find" },
        { "<leader>g", group = "+git" },
        { "<leader>gh", group = "+hunks" },
        { "<leader>q", group = "+quit/session" },
        { "<leader>s", group = "+search" },
        { "<leader>u", group = "+ui" },
        { "<leader>x", group = "+diagnostics/quickfix" },
        { "<leader>*", hidden = true }, -- hide the keymap for vim-visual-star-search
      },
      keys = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },
}
