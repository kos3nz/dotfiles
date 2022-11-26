local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      -- text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-f>", -- binding to scroll down inside the popup
    scroll_up = "<c-b>", -- binding to scroll up inside the popup
  },
  window = {
    border = "none", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 4, -- spacing between columns
    align = "left", -- align columns left, center or right
  },
  ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  show_keys = true, -- show the currently pressed key and its label as a message in the command line
  triggers = "auto", -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
  -- disable the WhichKey popup for certain buf types and file types.
  -- Disabled by deafult for Telescope
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
}

local opts = {
  mode = "n", -- NORMAL mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  b = {
    name = "Buffer",
    p = { "<Cmd>BufferPick<CR>", "BufferPick" },

    b = { "<Cmd>BufferOrderByBufferNumber<CR>", "BufferOrderByBufferNumber" },
    d = { "<Cmd>BufferOrderByDirectory<CR>", "BufferOrderByDirectory" },
    l = { "<Cmd>BufferOrderByLanguage<CR>", "BufferOrderByLanguage" },
    w = { "<Cmd>BufferOrderByWindowNumber<CR>", "BufferOrderByWindowNumber" },
  },

  c = { "<Cmd>NvimTreeCollapse<CR>", "NvimTreeCollapse" },

  d = {
    e = { "<Cmd>lua _DENO()<CR>", "DENO" },
  },

  e = { "<Cmd>NvimTreeToggle<CR>", "NvimTreeToggle" },

  f = {
    name = "Find",
    b = { "<Cmd>Telescope grep_string<CR>", "Find Text Under Cursor" },
    c = { "<Cmd>Telescope buffers<CR>", "List Open Buffers" },
    h = { "<Cmd>Telescope help_tags<CR>", "List of Help Tags" },
    f = { "<Cmd>Telescope find_files<CR>", "Find Files" },
    s = { "<Cmd>Telescope live_grep<CR>", "Find Text" },
  },

  g = {
    name = "Git",
    b = { "<Cmd>Telescope git_branches<CR>", "List Git Branches" },
    c = { "<Cmd>Telescope git_commits<CR>", "List Git Commits" },
    f = { "<Cmd>Telescope git_bcommits<CR>", "List Git Commits For Current File" },
    s = { "<Cmd>Telescope git_status<CR>", "List Changes Per File With Diff" },
    t = { "<Cmd>Telescope git_stash<CR>", "List Stash Items" },

    l = { "<Cmd>Gitsigns blame_lines<CR>", "Git Blame Under Cursor" },
    r = { "<Cmd>Gitsigns reset_hunk<CR>", "Reset Changes Under Cursor" },
    p = { "<Cmd>Gitsigns preview_hunk<CR>", "Preview Diff Under Cursor" },

    u = { "<Cmd>lua _GITUI()<CR>", "GITUI" },
  },

  h = { ":nohl<CR>", "Clear Search Highlight" },

  n = {
    c = { "<Cmd>lua _NCDU()<CR>", "NCDU" },
  },

  m = { "<Cmd>MaximizerToggle<CR>", "Maximize Window" },

  t = {
    name = "Tab",
    o = { ":tabnew<CR>", "Open New Tab" },
    x = { ":tabclose<CR>", "Close Tab" },
    l = { ":tabn<CR>", "Go To Next Tab" },
    h = { ":tabp<CR>", "Go To Previous Tab" },
  },

  w = { "<Cmd>BufferClose<CR>", "Close Buffer" },

  ["1"] = { "<Cmd>BufferGoto 1<CR>", "BufferGoto 1" },
  ["2"] = { "<Cmd>BufferGoto 2<CR>", "BufferGoto 2" },
  ["3"] = { "<Cmd>BufferGoto 3<CR>", "BufferGoto 3" },
  ["4"] = { "<Cmd>BufferGoto 4<CR>", "BufferGoto 4" },
  ["5"] = { "<Cmd>BufferGoto 5<CR>", "BufferGoto 5" },
  ["6"] = { "<Cmd>BufferGoto 6<CR>", "BufferGoto 6" },
  ["7"] = { "<Cmd>BufferGoto 7<CR>", "BufferGoto 7" },
  ["8"] = { "<Cmd>BufferGoto 8<CR>", "BufferGoto 8" },
  ["9"] = { "<Cmd>BufferGoto 9<CR>", "BufferGoto 9" },
  ["0"] = { "<Cmd>BufferLast<CR>", "BufferLast" },

  ["+"] = { "<C-a>", "Increment Number" },
  ["-"] = { "<C-x>", "Decrement Number" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
