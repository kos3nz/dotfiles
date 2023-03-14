-- local get_icon = require("astronvim.utils").get_icon

vim.cmd([[highlight NeoTreeModified guifg=#4ade80 gui=nocombine]])

return {
  "nvim-neo-tree/neo-tree.nvim",
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
      modified = {
        symbol = "",
        highlight = "NeoTreeModified",
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
      },
      git_status = {
        symbols = {
          -- Change type
          added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = "", --  this can only be used in the git_status source
          -- renamed = get_icon "GitRenamed",
          -- untracked = get_icon("GitUntracked"),
          -- ignored = get_icon("GitIgnored"),
          -- unstaged = get_icon("GitUnstaged"),
          -- staged = get_icon("GitStaged"),
          -- conflict = get_icon("GitConflict"),
        },
      },
    },

    window = {
      position = "left",
      width = 32,
      mappings = {
        ["<space>"] = false, -- disable space until we figure out which-key disabling
        ["[b"] = false, -- "prev_source",
        ["]b"] = false, -- "next_source",
        ["z"] = false,
        o = "open",
        O = "system_open",
        h = "parent_or_close",
        H = "close_all_nodes",
        l = "child_or_open",
        -- ["<2-LeftMouse>"] = "open",
        -- ["<cr>"] = "open",
        -- ["o"] = "open",
        -- ["S"] = "open_split",
        -- ["s"] = "open_vsplit",
        -- ["C"] = "close_node",
        -- ["<bs>"] = "navigate_up",
        -- ["."] = "set_root",
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
    },

    nesting_rules = {},

    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = true,
        hide_by_name = {
          ".git",
          "node_modules",
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
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
      follow_current_file = true,
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
      window = {
        mappings = {
          O = "system_open",
          h = "close_node",
          ["zh"] = "toggle_hidden",
          ["."] = "toggle_hidden",
        },
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

    event_handlers = {
      {
        event = "vim_buffer_enter",
        handler = function(_)
          if vim.bo.filetype == "neo-tree" then
            vim.wo.signcolumn = "auto"
          end
        end,
      },
    },
  },
}
