return {
  close_if_last_window = true,
  popup_border_style = "rounded",
  enable_git_status = true,
  enable_diagnostics = false,
  default_component_configs = {
    indent = {
      indent_size = 2,
      padding = 0,
      with_markers = true,
      indent_marker = "│",
      last_indent_marker = "└",
      highlight = "NeoTreeIndentMarker",
      with_expanders = false,
      expander_highlight = "NeoTreeExpander",
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
        -- renamed = "", -- this can only be used in the git_status source
        -- Status type
        -- untracked = "",
        -- ignored = "",
        -- unstaged = "",
        -- staged = "",
        -- conflict = "",
      },
    },
  },
  window = {
    position = "left",
    width = 32,
    mappings = {
      ["l"] = "open",
      ["h"] = "close_node",
      ["z"] = false,
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
        ".DS_Store",
        "thumbs.db",
        "node_modules",
        "__pycache__",
      },
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
}
