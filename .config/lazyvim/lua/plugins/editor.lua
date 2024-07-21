return {
  -- buffer remove
  {
    "echasnovski/mini.bufremove",

    keys = {
      {
        "<leader>d",
        function()
          local bufs = vim.fn.getbufinfo({ buflisted = true })

          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end

          local status = pcall(require, "dashboard")
          if status and not bufs[2] then
            vim.cmd("Dashboard")
          end
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>bd",
        function()
          local bufs = vim.fn.getbufinfo({ buflisted = true })

          local bd = require("mini.bufremove").delete
          if vim.bo.modified then
            local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
            if choice == 1 then -- Yes
              vim.cmd.write()
              bd(0)
            elseif choice == 2 then -- No
              bd(0, true)
            end
          else
            bd(0)
          end

          local status = pcall(require, "dashboard")
          if status and not bufs[2] then
            vim.cmd("Dashboard")
          end
        end,
        desc = "Delete Buffer",
      },
      {
        "<leader>D",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
      {
        "<leader>bD",
        function()
          require("mini.bufremove").delete(0, true)
        end,
        desc = "Delete Buffer (Force)",
      },
    },
  },

  -- Surround actions
  {
    "echasnovski/mini.surround",
    recommended = true,
    keys = function(_, keys)
      -- Populate the keys based on the user's options
      local opts = LazyVim.opts("mini.surround")
      local mappings = {
        { opts.mappings.add, desc = "Add Surrounding", mode = { "n", "v" } },
        { opts.mappings.delete, desc = "Delete Surrounding" },
        { opts.mappings.replace, desc = "Replace Surrounding" },
      }
      mappings = vim.tbl_filter(function(m)
        return m[1] and #m[1] > 0
      end, mappings)
      return vim.list_extend(mappings, keys)
    end,
    opts = {
      mappings = {
        add = "ys", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        replace = "cs", -- Replace surrounding
      },
    },
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

  -- fuzzy finder.
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>ff",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
          })
        end,
        desc = "Find files",
      },
      {
        "<leader>fF",
        function()
          require("telescope.builtin").find_files({
            hidden = true,
            no_ignore = true,
          })
        end,
        desc = "Find files",
      },
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fw",
        function()
          require("telescope.builtin").live_grep({
            additional_args = function(args)
              return vim.list_extend(args, { "--hidden" })
            end,
          })
        end,
        desc = "Find words",
      },
      {
        "<leader>fW",
        function()
          require("telescope.builtin").live_grep({
            additional_args = function(args)
              return vim.list_extend(args, { "--hidden", "--no-ignore" })
            end,
          })
        end,
        desc = "Find words in all files",
      },
    },
    opts = function(_, opts)
      local actions = require("telescope.actions")

      opts.defaults = {
        prompt_prefix = "> ",
        selection_caret = "> ",
        path_display = { "truncate" },
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
            preview_height = 0.6,
          },
          width = 0.9,
          height = 0.9,
          preview_cutoff = 80,
        },

        mappings = {
          i = {
            ["<C-f>"] = false,

            ["<C-n>"] = actions.move_selection_next,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-p>"] = actions.move_selection_previous,

            ["<C-c>"] = actions.close,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,

            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            -- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            -- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-l>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<Tab>"] = actions.send_selected_to_qflist + actions.open_qflist,
            ["<S-Tab>"] = actions.send_to_qflist + actions.open_qflist,
            -- ["<C-l>"] = actions.complete_tag,
            ["<C-/>"] = actions.which_key,
            ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
            ["<C-w>"] = { "<c-s-w>", type = "command" },

            -- disable c-j because we dont want to allow new lines #2123
            -- ["<C-j>"] = actions.nop,
          },

          n = {
            ["<esc>"] = actions.close,
            ["<CR>"] = actions.select_default,
            ["<C-x>"] = actions.select_horizontal,
            ["<C-v>"] = actions.select_vertical,
            ["<C-t>"] = actions.select_tab,

            ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
            ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

            ["j"] = actions.move_selection_next,
            ["k"] = actions.move_selection_previous,
            ["H"] = actions.move_to_top,
            ["M"] = actions.move_to_middle,
            ["L"] = actions.move_to_bottom,

            ["<Down>"] = actions.move_selection_next,
            ["<Up>"] = actions.move_selection_previous,
            ["gg"] = actions.move_to_top,
            ["G"] = actions.move_to_bottom,

            ["<C-u>"] = actions.preview_scrolling_up,
            ["<C-d>"] = actions.preview_scrolling_down,

            ["<PageUp>"] = actions.results_scrolling_up,
            ["<PageDown>"] = actions.results_scrolling_down,

            ["?"] = actions.which_key,
          },
        },
      }
      opts.pickers = { colorscheme = { enable_preview = true } }
      opts.extensions = {
        "live_grep_args",
        "textcase",
      }

      return opts
    end,
    config = function(_, opts)
      local mocha = require("catppuccin.palettes").get_palette("mocha")
      -- customizing highlights
      -- https://github.com/NvChad/base46/blob/master/lua/base46/integrations/telescope.lua
      vim.api.nvim_set_hl(0, "TelescopePromptPrefix", { fg = mocha.green })
      vim.api.nvim_set_hl(0, "TelescopeSelectionCaret", { fg = mocha.green })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "TelescopeResults",
        callback = function(ctx)
          vim.api.nvim_buf_call(ctx.buf, function()
            vim.fn.matchadd("TelescopeParent", "\t\t.*$")
            vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
          end)
        end,
      })

      local function filenameFirst(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == "." then
          return " " .. tail
        end
        return string.format("%s\t\t%s", " " .. tail, parent)
      end

      local format = {
        pickers = {
          find_files = {
            path_display = filenameFirst,
          },
          live_grep = {
            path_display = filenameFirst,
          },
          git_files = {
            path_display = filenameFirst,
          },
          oldfiles = {
            path_display = filenameFirst,
          },
          lsp_references = {
            path_display = filenameFirst,
          },
        },
      }

      for k, v in pairs(format) do
        opts[k] = v
      end

      require("telescope").setup(opts)
    end,
  },
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      "tom-anders/telescope-vim-bookmarks.nvim",
      "johmsalas/text-case.nvim",
      build = "make",
      config = function()
        local telescope = require("telescope")

        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")
        telescope.load_extension("vim_bookmarks")
        telescope.load_extension("textcase")
      end,
    },
  },

  -- which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      plugins = { spelling = true },
      spec = {
        mode = { "n" },
        { "<leader>w", "<cmd>w<cr>", desc = "Save" },
        { "g", group = "+goto" },
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
      },
    },
    config = function(_, opts)
      local wk = require("which-key")
      wk.setup(opts)
    end,
  },
}
