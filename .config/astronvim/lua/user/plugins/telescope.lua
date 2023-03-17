return {
  "nvim-telescope/telescope.nvim",
  dependencies = { -- add a new dependency to telescope that is our new plugin
    "nvim-telescope/telescope-live-grep-args.nvim",
    "tom-anders/telescope-vim-bookmarks.nvim",
  },
  opts = function(_, opts)
    local actions = require("telescope.actions")

    opts.defaults = {

      prompt_prefix = " ",
      selection_caret = "❯ ",
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
          ["<C-n>"] = actions.move_selection_next,
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
          ["<C-j>"] = actions.nop,
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

  config = function(plugin, opts)
    require("plugins.configs.telescope")(plugin, opts)

    local telescope = require("telescope")
    telescope.load_extension("live_grep_args")
    telescope.load_extension("vim_bookmarks")
    telescope.load_extension("textcase")
  end,
}
