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
    -- disable default mappings
    ["<leader>C"] = false, -- Force close buffer
    ["<leader>fn"] = false, -- New File
    ["<leader>Sd"] = false, -- Delete session
    ["<leader>Sf"] = false, -- Search session
    ["<leader>Sl"] = false, -- Load last session
    ["<leader>S."] = false, -- Load current directory session

    ["<Enter>"] = { "o<Esc>", desc = "Insert new line below" },
    ["<S-Enter>"] = { "O<Esc>", desc = "Insert new line above" },

    ["gu"] = { "gu", desc = "To lower case" },
    ["gU"] = { "gU", desc = "To Upper case" },
    ["g~"] = { "g~", desc = "Switch case" },

    -- cursor navigation
    ["<C-d>"] = { "25j" },
    ["<C-u>"] = { "25k" },
    ["<C-f>"] = { "50j" },
    ["<C-b>"] = { "50k" },
    ["J"] = { "5j" },
    ["K"] = { "5k" },
    ["M"] = { "J" },
    ["<C-a>"] = { "0" },
    ["<C-e>"] = { "$" },
    ["<C-s>"] = { "^" },
    ["<C-t>"] = { "%" },
    ["gM"] = { "gM", desc = "Move to middle of line" },

    ["<Tab>"] = { ">>" },
    ["<S-Tab>"] = { "<<" },

    -- delete single character without yanking into register
    ["x"] = { '"_x' },

    -- select all
    -- ["<A-a>"] = { "ggVG" },

    -- save without formatting
    ["<leader>W"] = { "<cmd>noa w<cr>", desc = "Save without formmating" },

    -- force quit
    ["<leader>Q"] = { "<cmd>qa!<cr>", desc = "Force quit" },

    -- move text up and Down
    -- ["<A-k>"] = { ":m .-2<cr>==", desc = "Move text up" },
    -- ["<A-j>"] = { ":m .+1<cr>==", desc = "Move text down" },
    ["<leader>ik"] = { ":m .-2<cr>==", desc = "Move text up", silent = true }, -- mapping for alacritty
    ["<leader>ij"] = { ":m .+1<cr>==", desc = "Move text down", silent = true }, -- mapping for alacritty

    -- window management
    ["<C-w>h"] = { "<C-w>s", desc = "Split window horizontally" },
    ["<C-w>m"] = { "<cmd>MaximizerToggle<cr>", desc = "Maximize window" },
    ["<leader>m"] = { "<cmd>MaximizerToggle<cr>", desc = "Maximize window" },

    -- resize
    ["<A-Left>"] = { ":vertical resize +2<cr>" },
    ["<A-Right>"] = { ":vertical resize -2<cr>" },
    ["<A-Down>"] = { ":resize -2<cr>" },
    ["<A-Up>"] = { ":resize +2<cr>" },
    ["<A-=>"] = { "<C-w>=", desc = "Resize equal" },

    -- manage buffers
    ["<leader>x"] = {
      function()
        astronvim.close_buf(0)
      end,
      desc = "Close buffer",
    },
    ["<leader>X"] = {
      function()
        astronvim.close_buf(0, true)
      end,
      desc = "Force close buffer",
    },
    ["<leader>bd"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
    ["<leader>bg"] = {
      function()
        require("bufferline").go_to_buffer(vim.fn.input("Buf number: "), true)
      end,
      desc = "Go to buffer by absolute number",
      noremap = true,
      silent = true,
    },
    ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
    ["<leader>bp"] = { "<cmd>BufferLineTogglePin<cr>", desc = "Toggle pin" },
    ["<leader>bs"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
    ["<leader>bt"] = { "<cmd>enew<cr>", desc = "New file" },
    ["<leader>bx"] = { "<cmd>lua Close_all_but_current() <cr>", desc = "Close other buffers" },
    ["<leader>bX"] = { "<cmd>lua Close_all_but_current(true) <cr>", desc = "Force close other buffers" },
    ["<leader>1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to Buffer 1" },
    ["<leader>2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to Buffer 2" },
    ["<leader>3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to Buffer 3" },
    ["<leader>4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to Buffer 4" },
    ["<leader>5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to Buffer 5" },
    ["<leader>6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Go to Buffer 6" },
    ["<leader>7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Go to Buffer 7" },
    ["<leader>8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Go to Buffer 8" },
    ["<leader>9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Go to Buffer 9" },

    -- terminal
    ["<C-\\>"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },

    -- comments
    ["<C-_>"] = { -- mapping for forward slash(/)
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      desc = "Comment line",
    },

    -- hop
    ["<leader>jl"] = { "<cmd>HopLineStart<cr>", desc = "HopLineStart" },
    ["<leader>js"] = {
      function()
        require("hop").hint_char1({ direction = require("hop.hint").AFTER_CURSOR, current_line_only = false })
      end,
      desc = "Hop onto character",
      remap = true,
    },
    ["<leader>jw"] = { "<cmd>HopWord<cr>", desc = "HopWord" },

    -- telescope
    ["<leader>fa"] = {
      function()
        require("telescope").extensions.live_grep_args.live_grep_args()
      end,
      desc = "Search words in all files",
    },
    ["<leader>fm"] = { "<cmd>Telescope vim_bookmarks current_file<cr>", desc = "Search bookmarks in current file" },
    ["<leader>fM"] = { "<cmd>Telescope vim_bookmarks all<cr>", desc = "Search all bookmarks" },
    ["<leader>fs"] = { "<cmd>Telescope lsp_document_symbols<cr>", desc = "Search document symbols" },
    ["<leader>ft"] = { "<cmd>TodoTelescope<cr>", desc = "Search Todos" },
    ["<leader>fw"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search words in current buffer" },

    -- trouble
    ["<leader>tt"] = { "<cmd>TroubleToggle<cr>" },
    ["<leader>tw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>" },
    ["<leader>td"] = { "<cmd>TroubleToggle document_diagnostics<cr>" },
    ["<leader>tq"] = { "<cmd>TroubleToggle quickfix<cr>" },
    ["<leader>tc"] = { "<cmd>TroubleToggle loclist<cr>" },
    ["<leader>tl"] = { "<cmd>TroubleToggle lsp_references<cr>" },
    ["gR"] = { "<cmd>TroubleToggle lsp_references<cr>" },

    -- git
    ["<leader>ga"] = { "<cmd>Telescope git_stash<CR>", desc = "Git stash" },
    ["<leader>gC"] = { "<cmd>Telescope git_bcommits<CR>", desc = "Git buffer commits" },
    ["[g"] = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", desc = "Previous Git hunk" },
    ["]g"] = { "<cmd>lua require('gitsigns').next_hunk()<cr>", desc = "Next Git hunk" },
    ["<leader>cc"] = { "<cmd>GitConflictChooseOurs<CR>", desc = "Git Conflict: Choose current" },
    ["<leader>ci"] = { "<cmd>GitConflictChooseTheirs<CR>", desc = "Git Conflict: Choose incoming" },
    ["<leader>cb"] = { "<cmd>GitConflictChooseBoth<CR>", desc = "Git Conflict: Choose both" },
    ["<leader>cn"] = { "<cmd>GitConflictChooseNone<CR>", desc = "Git Conflict: Choose none" },
    ["<leader>cl"] = { "<cmd>GitConflictListQf<CR>", desc = "Git Conflict: List of conflicts" },
    ["[c"] = { "<cmd>GitConflictPrevConflict<CR>", desc = "Git Conflict: Prev conflict" },
    ["]c"] = { "<cmd>GitConflictNextConflict<CR>", desc = "Git Conflict: Next conflict" },

    -- dashboard
    ["<leader>a"] = { "<cmd>Alpha<cr>", desc = "Alpha Dashboard" },

    -- doge
    ["<leader>d"] = { "<cmd>DogeGenerate<cr>", desc = "Create documentaion" },

    -- session manager
    ["<leader>rl"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" },
    ["<leader>rs"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save this session" },
    ["<leader>rd"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session" },
    ["<leader>rf"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" },
    ["<leader>r."] = { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" },

    -- textcase
    ["<leader>sa"] = { "<cmd>TextCaseOpenTelescope<cr>", desc = "Search text cases" },
    ["ga."] = { "<cmd>TextCaseOpenTelescope<cr>", desc = "Search text cases" },
    ["gau"] = { "<cmd>lua require('textcase').current_word('to_upper_case')<cr>", desc = "Convert to_upper_case" },
    ["gal"] = { "<cmd>lua require('textcase').current_word('to_lower_case')<cr>", desc = "Convert to_lower_case" },
    ["gas"] = { "<cmd>lua require('textcase').current_word('to_snake_case')<cr>", desc = "Convert to_snake_case" },
    ["gaa"] = { "<cmd>lua require('textcase').current_word('to_dash_case')<cr>", desc = "Convert to_dash_case" },
    ["gan"] = { "<cmd>lua require('textcase').current_word('to_constant_case')<cr>", desc = "Convert to_constant_case" },
    ["gad"] = { "<cmd>lua require('textcase').current_word('to_dot_case')<cr>", desc = "Convert to_dot_case" },
    ["gar"] = { "<cmd>lua require('textcase').current_word('to_phrase_case')<cr>", desc = "Convert to_phrase_case" },
    ["gac"] = { "<cmd>lua require('textcase').current_word('to_camel_case')<cr>", desc = "Convert to_camel_case" },
    ["gap"] = { "<cmd>lua require('textcase').current_word('to_pascal_case')<cr>", desc = "Convert to_pascal_case" },
    ["gat"] = { "<cmd>lua require('textcase').current_word('to_title_case')<cr>", desc = "Convert to_title_case" },
    ["gaf"] = { "<cmd>lua require('textcase').current_word('to_path_case')<cr>", desc = "Convert to_path_case" },

    ["gaU"] = { "<cmd>lua require('textcase').lsp_rename('to_upper_case')<cr>", desc = "LSP rename to_upper_case" },
    ["gaL"] = { "<cmd>lua require('textcase').lsp_rename('to_lower_case')<cr>", desc = "LSP rename to_lower_case" },
    ["gaS"] = { "<cmd>lua require('textcase').lsp_rename('to_snake_case')<cr>", desc = "LSP rename to_snake_case" },
    ["gaA"] = { "<cmd>lua require('textcase').lsp_rename('to_dash_case')<cr>", desc = "LSP rename to_dash_case" },
    ["gaN"] = {
      "<cmd>lua require('textcase').lsp_rename('to_constant_case')<cr>",
      desc = "LSP rename to_constant_case",
    },
    ["gaD"] = { "<cmd>lua require('textcase').lsp_rename('to_dot_case')<cr>", desc = "LSP rename to_dot_case" },
    ["gaR"] = { "<cmd>lua require('textcase').lsp_rename('to_phrase_case')<cr>", desc = "LSP rename to_phrase_case" },
    ["gaC"] = { "<cmd>lua require('textcase').lsp_rename('to_camel_case')<cr>", desc = "LSP rename to_camel_case" },
    ["gaP"] = { "<cmd>lua require('textcase').lsp_rename('to_pascal_case')<cr>", desc = "LSP rename to_pascal_case" },
    ["gaT"] = { "<cmd>lua require('textcase').lsp_rename('to_title_case')<cr>", desc = "LSP rename to_title_case" },
    ["gaF"] = { "<cmd>lua require('textcase').lsp_rename('to_path_case')<cr>", desc = "LSP rename to_path_case" },

    ["gAu"] = { "<cmd>lua require('textcase').operator('to_upper_case')<cr>", desc = "to_upper_case" },
    ["gAl"] = { "<cmd>lua require('textcase').operator('to_lower_case')<cr>", desc = "to_lower_case" },
    ["gAs"] = { "<cmd>lua require('textcase').operator('to_snake_case')<cr>", desc = "to_snake_case" },
    ["gAa"] = { "<cmd>lua require('textcase').operator('to_dash_case')<cr>", desc = "to_dash_case" },
    ["gAn"] = { "<cmd>lua require('textcase').operator('to_constant_case')<cr>", desc = "to_constant_case" },
    ["gAd"] = { "<cmd>lua require('textcase').operator('to_dot_case')<cr>", desc = "to_dot_case" },
    ["gAr"] = { "<cmd>lua require('textcase').operator('to_phrase_case')<cr>", desc = "to_phrase_case" },
    ["gAc"] = { "<cmd>lua require('textcase').operator('to_camel_case')<cr>", desc = "to_camel_case" },
    ["gAp"] = { "<cmd>lua require('textcase').operator('to_pascal_case')<cr>", desc = "to_pascal_case" },
    ["gAt"] = { "<cmd>lua require('textcase').operator('to_title_case')<cr>", desc = "to_title_case" },
    ["gAf"] = { "<cmd>lua require('textcase').operator('to_path_case')<cr>", desc = "to_path_case" },

    -- CamelCaseMotion
    ["w"] = { "<Plug>CamelCaseMotion_w" },
    ["e"] = { "<Plug>CamelCaseMotion_e" },
    ["b"] = { "<Plug>CamelCaseMotion_b" },
    ["cm"] = { "c<Plug>CamelCaseMotion_ie", desc = "Change word segment forward" },
    ["dm"] = { "d<Plug>CamelCaseMotion_ie", desc = "Delete word segment forward" },

    -- vim-sneak
    ["f"] = { "<Plug>Sneak_f" },
    ["F"] = { "<Plug>Sneak_F" },
    ["t"] = { "<Plug>Sneak_t" },
    ["T"] = { "<Plug>Sneak_T" },

    -- ReplaceWithRegister
    ["grw"] = { "<Plug>ReplaceWithRegisterOperatoriw", desc = "<Plug>ReplaceWithRegisterOperator_iw" },
    ["griw"] = { "<Plug>ReplaceWithRegisterOperatoriw", desc = "<Plug>ReplaceWithRegisterOperator_iw" },
    ["grm"] = {
      "<Plug>ReplaceWithRegisterOperator<Plug>CamelCaseMotion_ie",
      desc = "<Plug>ReplaceWithRegisterOperator_m",
    },
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
    ["<C-t>"] = { "<C-o>%" },

    ["<C-j>"] = { "<Esc>gMa" }, -- move to middle of line

    -- move text up and down
    -- ["<A-k>"] = { "<Esc>:m .-2<cr>==gi" },
    -- ["<A-j>"] = { "<Esc>:m .+1<cr>==gi" },

    -- comments
    ["<C-_>"] = {
      function()
        require("Comment.api").toggle.linewise.current()
      end,
      desc = "Comment line",
    },
  },

  --------------------
  -- Visual mode
  --------------------
  v = {
    -- stay in indent mode
    [">"] = { ">gv" },
    ["<"] = { "<gv" },
    ["<Tab>"] = { ">gv" },
    ["<S-Tab>"] = { "<gv" },

    -- cursor navigation
    ["J"] = { "5j" },
    ["K"] = { "5k" },
    ["<C-a>"] = { "0" },
    ["<C-e>"] = { "$" },
    ["<C-s>"] = { "^" },
    ["<C-t>"] = { "%" },

    -- move text up and down
    -- ["<A-k>"] = { ":m '<-2<cr>gv=gv" },
    -- ["<A-j>"] = { ":m '>+1<cr>gv=gv" },
    ["<leader>ik"] = { ":m '<-2<cr>gv=gv", desc = "Move text up", silent = true }, -- mapping for alacritty
    ["<leader>ij"] = { ":m '>+1<cr>gv=gv", desc = "Move text down", silent = true }, -- mapping for alacritty

    -- ["p"] = { "_dP" },

    -- comments
    ["<C-_>"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      desc = "Toggle comment line",
    },

    -- CamelCaseMotion
    ["m"] = { "<Plug>CamelCaseMotion_ie" },
  },

  --------------------
  -- Visual Block mode
  --------------------
  x = {
    -- stay in indent mode
    [">"] = { ">gv" },
    ["<"] = { "<gv" },
    ["<Tab>"] = { ">gv" },
    ["<S-Tab>"] = { "<gv" },

    -- cursor navigation
    ["<C-a>"] = { "0" },
    ["<C-e>"] = { "$" },
    ["<C-s>"] = { "^" },
    ["<C-t>"] = { "%" },

    -- move text up and down
    -- ["<A-k>"] = { ":move '<-2<cr>gv=gv" },
    -- ["<A-j>"] = { ":move '>+1<cr>gv=gv" },
    ["<leader>ik"] = { ":m '<-2<cr>gv=gv", desc = "Move text up", silent = true }, -- mapping for alacritty
    ["<leader>ij"] = { ":m '>+1<cr>gv=gv", desc = "Move text down", silent = true }, -- mapping for alacritty

    -- comments
    ["<C-_>"] = {
      "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
      desc = "Toggle comment line",
    },

    -- CamelCaseMotion
    ["m"] = { "<Plug>CamelCaseMotion_ie" },
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
    ["<C-\\>"] = { "<cmd>ToggleTerm direction=float<cr>" },
  },

  --------------------
  -- Operator pending mode
  --------------------
  o = {
    ["w"] = { "iw" },
    -- ["t"] = { "at" },
    -- ["m"] = { "<Plug>CamelCaseMotion_ie" }, -- this operation is a bit slow thant mapping "dm" and "cm" respectively

    -- vim-sneak
    ["f"] = { "<Plug>Sneak_f" },
    ["F"] = { "<Plug>Sneak_F" },
    ["t"] = { "<Plug>Sneak_t" },
    ["T"] = { "<Plug>Sneak_T" },
  },
}
