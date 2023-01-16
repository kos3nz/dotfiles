-- Mapping data with "desc" stored directly by vim.keymap.set().
--
-- Please use this mappings table to set keyboard mapping since this is the
-- lower level configuration and more robust one. (which-key will
-- automatically pick-up stored data by this setting.)

-- setting a mapping to false will disable it
-- ["<esc>"] = false,

return {
  --------------------
  -- Normal mode
  --------------------
  n = {
    -- mappings seen under group name "Buffer"
    ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
    ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    ["<leader>bp"] = { "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
    ["<leader>bt"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    ["<leader>bw"] = { "<cmd>sil exe 'wa|%bd|e#|bd#|normal `'<cr>", desc = "Save and close other buffers" },
    ["<leader>bq"] = { "<cmd>sil exe '%bd|e#|bd#|normal `'<cr>", desc = "Close other buffers exept unsaved" },
    ["<leader>bg"] = {
      function()
        require("bufferline").go_to_buffer(vim.fn.input("Buf number: "), true)
      end,
      desc = "Go to buffer by absolute number",
      noremap = true,
      silent = true,
    },
    ["<leader>1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to Buffer 1" },
    ["<leader>2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to Buffer 2" },
    ["<leader>3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to Buffer 3" },
    ["<leader>4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to Buffer 4" },
    ["<leader>5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to Buffer 5" },
    ["<leader>6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Go to Buffer 6" },
    ["<leader>7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Go to Buffer 7" },
    ["<leader>8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Go to Buffer 8" },
    ["<leader>9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Go to Buffer 9" },

    ["<Enter>"] = { "o<Esc>", desc = "Insert new line below" },
    ["<S-Enter>"] = { "O<Esc>", desc = "Insert new line above" },

    -- cursor navigation
    ["<C-a>"] = { "0" },
    ["<C-e>"] = { "$" },
    ["<C-s>"] = { "^" },
    ["<C-y>"] = { "%" },

    -- delete single character without yanking into register
    ["x"] = { '"_x' },

    ["gu"] = { "gu", desc = "To lower case" },
    ["gU"] = { "gU", desc = "To Upper case" },
    ["g~"] = { "g~", desc = "Switch case" },
    ["gM"] = { "gM", desc = "Move to middle of line" },
    ["<C-j>"] = { "gM", desc = "Move to middle of line" },

    -- select all
    ["<A-a>"] = { "ggVG" },

    -- force quit
    ["<leader>Q"] = { "<cmd>qa!<cr>", desc = "Force Quit" },

    -- move text up and Down
    ["<A-k>"] = { ":m .-2<cr>==", desc = "Move text up" },
    ["<A-j>"] = { ":m .+1<cr>==", desc = "Move text down" },

    -- window management
    ["<C-w>h"] = { "<C-w>s", desc = "Split window horizontally" },
    ["<leader>m"] = { "<cmd>MaximizerToggle<cr>", desc = "Maximize window" },

    -- resize
    ["<A-Left>"] = { ":vertical resize +2<cr>" },
    ["<A-Right>"] = { ":vertical resize -2<cr>" },
    ["<A-Down>"] = { ":resize -2<cr>" },
    ["<A-Up>"] = { ":resize +2<cr>" },
    ["<A-=>"] = { "<C-w>=", desc = "Resize equal" },

    -- terminal
    ["<C-\\>"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },

    -- hop
    ["<leader>j"] = { "<cmd>HopLineStart<cr>", desc = "HopLineStart" },
    ["f"] = {
      function()
        require("hop").hint_char1({ direction = require("hop.hint").AFTER_CURSOR, current_line_only = false })
      end,
      desc = "Hop onto character",
      remap = true,
    },
    ["F"] = {
      function()
        require("hop").hint_char1({ direction = require("hop.hint").BEFORE_CURSOR, current_line_only = false })
      end,
      desc = "Hop onto character",
      remap = true,
    },

    -- telescope
    ["<leader>fw"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search words in current buffer" },
    ["<leader>fW"] = {
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "Search words in all files",
    },
    ["<leader>ft"] = { "<cmd>TodoTelescope<cr>", desc = "Search Todos" },
    ["<leader>fm"] = { "<cmd>Telescope vim_bookmarks current_file<cr>", desc = "Search bookmarks in current file" },
    ["<leader>fM"] = { "<cmd>Telescope vim_bookmarks all<cr>", desc = "Search all bookmarks" },
    ["<leader>fs"] = { "<cmd>Telescope lsp_document_symbols<cr>", desc = "Search document symbols" },

    -- trouble
    ["<leader>xx"] = { "<cmd>TroubleToggle<cr>" },
    ["<leader>xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>" },
    ["<leader>xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>" },
    ["<leader>xq"] = { "<cmd>TroubleToggle quickfix<cr>" },
    ["<leader>xl"] = { "<cmd>TroubleToggle loclist<cr>" },
    ["gR"] = { "<cmd>TroubleToggle lsp_references<cr>" },

    -- git
    ["<leader>ga"] = { "<cmd>Telescope git_stash<CR>", desc = "Git stash" },
    ["<leader>gC"] = { "<cmd>Telescope git_bcommits<CR>", desc = "Git buffer commits" },
    ["[g"] = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", desc = "Previous Git hunk" },
    ["]g"] = { "<cmd>lua require('gitsigns').next_hunk()<cr>", desc = "Next Git hunk" },
    ["co"] = { "<cmd>GitConflictChooseOurs<CR>", desc = "Git Conflict: Choose ours" },
    ["ct"] = { "<cmd>GitConflictChooseTheirs<CR>", desc = "Git Conflict: Choose theirs" },
    ["cb"] = { "<cmd>GitConflictChooseBoth<CR>", desc = "Git Conflict: Choose both" },
    ["cn"] = { "<cmd>GitConflictChooseNone<CR>", desc = "Git Conflict: Choose none" },
    ["[x"] = { "<cmd>GitConflictPrevConflict<CR>", desc = "Git Conflict: Prev conflict" },
    ["]x"] = { "<cmd>GitConflictNextConflict<CR>", desc = "Git Conflict: Next conflict" },
    ["cl"] = { "<cmd>GitConflictListQf<CR>", desc = "Git Conflict: List of conflicts" },

    -- dashboard
    ["<leader>a"] = { "<cmd>Alpha<cr>", desc = "Alpha Dashboard" },

    -- doge
    ["<leader>d"] = { "<cmd>DogeGenerate<cr>", desc = "Create documentaion" },

    -- sniprun
    ["<leader>rr"] = { "<cmd>SnipRun<cr>", desc = "Run" },
    ["<leader>rs"] = { "<cmd>SnipReset<cr>", desc = "Abort" },
    ["<leader>rc"] = { "<cmd>SnipClose<cr>", desc = "Clear output" },

    -- symbols-outline
    ["<leader>lS"] = { "<cmd>SymbolsOutline<cr>", desc = "Toggle outline" },
  },

  --------------------
  -- Insert mode
  --------------------
  i = {
    -- ["jk"] = { "<esc>" },

    -- cursor navigation
    -- ["<C-k>"] = { "<Up>" },
    ["<C-p>"] = { "<Up>" },
    -- ["<C-j>"] = { "<Down>" },
    ["<C-n>"] = { "<Down>" },
    ["<C-b>"] = { "<Left>" },
    ["<C-l>"] = { "<Right>" },
    ["<C-f>"] = { "<Right>" },
    ["<C-a>"] = { "<Esc>I" },
    ["<C-e>"] = { "<Esc>A" },
    ["<C-s>"] = { "<C-o>^" },
    ["<C-d>"] = { "<Del>" },
    ["<C-k>"] = { "<C-o>D" },
    ["<C-y>"] = { "<C-o>%" },

    ["<C-j>"] = { "<Esc>gMa" }, -- move to middle of line

    -- ["<C-y>"] = { "<C-o>b" },
    -- ["<C-i>"] = { "<C-o>w" },

    -- move text up and down
    ["<A-k>"] = { "<Esc>:m .-2<cr>==gi" },
    ["<A-j>"] = { "<Esc>:m .+1<cr>==gi" },
  },

  --------------------
  -- Visual mode
  --------------------
  v = {
    -- stay in indent mode
    ["<"] = { "<gv" },
    [">"] = { ">gv" },

    -- cursor navigation
    ["<C-a>"] = { "0" },
    ["<C-e>"] = { "$" },
    ["<C-s>"] = { "^" },
    ["<C-y>"] = { "%" },

    -- move text up and down
    ["<A-k>"] = { ":m '<-2<cr>gv=gv" },
    ["<A-j>"] = { ":m '>+1<cr>gv=gv" },

    -- ["p"] = { "_dP" },

    -- sniprun
    ["f"] = { "<cmd>SnipRun<cr>", desc = "Snip Run" },
  },

  --------------------
  -- Visual Block mode
  --------------------
  x = {
    -- stay in indent mode
    ["<"] = { "<gv" },
    [">"] = { ">gv" },

    -- cursor navigation
    ["<C-a>"] = { "0" },
    ["<C-e>"] = { "$" },
    ["<C-s>"] = { "^" },
    ["<C-y>"] = { "%" },

    -- move text up and down
    ["<A-k>"] = { ":move '<-2<cr>gv=gv" },
    ["<A-j>"] = { ":move '>+1<cr>gv=gv" },
  },

  --------------------
  -- Command mode
  --------------------
  c = {
    -- emacs-ish key bindings
    ["<C-j>"] = { "<Down>" },
    ["<C-k>"] = { "<Up>" },
    ["<C-l>"] = { "<Right>" },
    ["<C-f>"] = { "<Right>" },
    ["<C-b>"] = { "<Left>" },
    ["<C-h>"] = { "<Bs>" },
    ["<C-a>"] = { "<S-Left>" },
    ["<C-e>"] = { "<S-Right>" },
  },

  --------------------
  -- Terminal mode
  --------------------
  t = {
    -- emacs-ish key bindings
    ["<C-j>"] = { "<Down>" },
    ["<C-k>"] = { "<Up>" },
    ["<C-l>"] = { "<Right>" },
    ["<C-f>"] = { "<Right>" },
    ["<C-b>"] = { "<Left>" },
    ["<C-h>"] = { "<Bs>" },

    -- terminal
    ["<C-\\>"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
  },
}
