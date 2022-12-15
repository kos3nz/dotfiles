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
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "<cr>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
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

  ["c"] = { "<cmd>BufferClose<cr>", "Close Buffer" },
  ["e"] = { "<cmd>NvimTreeToggle<cr>", "NvimTreeToggle" },
  ["f"] = { "<cmd>Telescope find_files<cr>", "Find Files" },
  ["F"] = { "<cmd>Telescope live_grep<cr>", "Find Text" },
  ["h"] = { "<cmd>nohl<cr>", "Clear Search Highlight" },
  ["j"] = { "<cmd>HopLineStart<cr>", "HopLineStart" },
  ["m"] = { "<cmd>MaximizerToggle<cr>", "Maximize Window" },
  ["w"] = { "<cmd>w<cr>", "Save" },
  ["W"] = { "<cmd>:noa w<cr>", "Save Without Format" },
  ["q"] = { "<cmd>q<cr>", "Quit" },
  ["Q"] = { "<cmd>q!<cr>", "Force Quit" },
  ["X"] = { "<cmd>wq<cr>", "Save and Quit" },

  b = {
    name = "Buffer",
    p = { "<cmd>BufferPick<cr>", "BufferPick" },
    c = { "<cmd>NvimTreeCollapse<cr>", "NvimTreeCollapse" },
    b = { "<cmd>BufferOrderByBufferNumber<cr>", "BufferOrderByBufferNumber" },
    d = { "<cmd>BufferOrderByDirectory<cr>", "BufferOrderByDirectory" },
    l = { "<cmd>BufferOrderByLanguage<cr>", "BufferOrderByLanguage" },
    w = { "<cmd>BufferOrderByWindowNumber<cr>", "BufferOrderByWindowNumber" },
  },

  d = {
    name = "Definition",
    d = { "<cmd>Lspsaga hover_doc<cr>", "Show Doc" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go To Declaration" },
    f = { "<cmd>Lspsaga lsp_finder<cr>", "Go To File Under Cursor" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go To Implementation" },
    p = { "<cmd>Lspsaga peek_definition<cr>", "See Definition And Edit" },
  },

  g = {
    name = "Git",
    b = { "<cmd>Telescope git_branches<cr>", "Checkout Branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout Commit" },
    f = { "<cmd>Telescope git_bcommits<cr>", "Checkout Commits For Current File" },
    s = { "<cmd>Telescope git_status<cr>", "Open Changed File" },
    t = { "<cmd>Telescope git_stash<cr>", "List Stash Items" },

    l = { "<cmd>Gitsigns blame_line<cr>", "Blame" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Changes" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Diff" },

    u = { "<cmd>lua _GITUI()<cr>", "Gitui" },
  },

  -- j = {
  --   name = "Jump",
  --   v = { "<cmd>HopVertical<cr>", "HopVertical" },
  --   s = { "<cmd>HopLineStart<cr>", "HopLineStart" },
  --   w = { "<cmd>HopWord<cr>", "HopWord" },
  --   ["/"] = { "<cmd>HopPattern<cr>", "HopPattern" },
  -- },

  l = {
    name = "LSP",
    a = { "<cmd>Lspsaga code_action<cr>", "Code Action" },
    b = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
    w = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
    d = { "<cmd>Lspsaga show_line_diagnostics<cr>", "Show line Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next Diagnostic" },
    k = { "<cmd>Lspsaga diagnostic_jump_prev<cr>", "Prev Diagnostic" },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
    o = { "<cmd>LSoutlineToggle<cr>", "Outline" },
    r = { "<cmd>Lspsaga rename<cr>", "Rename" },
    R = { "<cmd>LspRestart<cr>", "Restart Server" },
    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
    S = {
      "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
      "Workspace Symbols",
    },
  },

  o = {
    h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Show Syntax Highlight Group" },
    p = { "<cmd>TSPlaygroundToggle<cr>", "TSPlaygroundToggle" },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    S = { "<cmd>PackerStatus<cr>", "Status" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  s = {
    name = "Search",
    b = { "<cmd>Telescope buffers<cr>", "Open Buffers" },
    c = { "<cmd>Telescope grep_string<cr>", "Find Text Under Cursor" },
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
    K = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    R = { "<cmd>Telescope registers<cr>", "Registers" },
  },

  t = {
    name = "Tab",
    o = { ":tabnew<cr>", "Open New Tab" },
    x = { ":tabclose<cr>", "Close Tab" },
    l = { ":tabn<cr>", "Go To Next Tab" },
    h = { ":tabp<cr>", "Go To Previous Tab" },
  },

  x = {
    name = "Function",
    d = { "<cmd>lua _DENO()<cr>", "Deno" },
    n = { "<cmd>lua _NCDU()<cr>", "NCDU" },
  },

  ["1"] = { "<cmd>BufferGoto 1<cr>", "BufferGoto 1" },
  ["2"] = { "<cmd>BufferGoto 2<cr>", "BufferGoto 2" },
  ["3"] = { "<cmd>BufferGoto 3<cr>", "BufferGoto 3" },
  ["4"] = { "<cmd>BufferGoto 4<cr>", "BufferGoto 4" },
  ["5"] = { "<cmd>BufferGoto 5<cr>", "BufferGoto 5" },
  ["6"] = { "<cmd>BufferGoto 6<cr>", "BufferGoto 6" },
  ["7"] = { "<cmd>BufferGoto 7<cr>", "BufferGoto 7" },
  ["8"] = { "<cmd>BufferGoto 8<cr>", "BufferGoto 8" },
  ["9"] = { "<cmd>BufferGoto 9<cr>", "BufferGoto 9" },
  ["0"] = { "<cmd>BufferLast<cr>", "BufferLast" },

  ["+"] = { "<C-a>", "Increment Number" },
  ["-"] = { "<C-x>", "Decrement Number" },
}

which_key.setup(setup)
which_key.register(mappings, opts)
