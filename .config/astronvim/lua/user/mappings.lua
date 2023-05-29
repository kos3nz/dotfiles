return {
  --------------------
  -- Normal mode
  --------------------
  n = {
    -- disable default mappings
    -- ["<leader>c"] = false, -- Close buffer
    -- ["<leader>C"] = false, -- Force close buffer
    ["<leader>Sd"] = false, -- Delete session
    ["<leader>Sf"] = false, -- Search session
    ["<leader>Ss"] = false, -- Save current session
    ["<leader>Sl"] = false, -- Load last session
    ["<leader>S."] = false, -- Load current directory session
    ["<leader>tf"] = false, -- ToggleTerm float
    ["<leader>th"] = false, -- ToggleTerm horizontal split
    ["<leader>tn"] = false, -- ToggleTerm node
    ["<leader>tp"] = false, -- ToggleTerm python
    ["<leader>tu"] = false, -- ToggleTerm gdu
    ["<leader>tv"] = false, -- ToggleTerm vertical split

    -- which key names
    ["<leader>j"] = { name = "Hop" },
    ["<leader>gx"] = { name = "Git Conflict" },
    ["<leader>lR"] = { name = "Restart Server" },
    ["<leader>r"] = { name = "Recent/Session" },
    ["<leader>t"] = { name = "Trouble" },
    ["<leader>T"] = { name = "ToggleTerm" },
    ["ga"] = { name = "Text Case" },
    ["gA"] = { name = "Text Case Operator Mode" },

    -- insert line
    ["<Enter>"] = { "o<Esc>", desc = "Insert new line below" },
    ["<S-Enter>"] = { "O<Esc>", desc = "Insert new line above" },

    -- change case
    ["gu"] = { "gu", desc = "To lower case" },
    ["gU"] = { "gU", desc = "To Upper case" },
    ["g~"] = { "g~", desc = "Switch case" },

    -- cursor navigation
    -- ["<C-d>"] = { "25j" },
    -- ["<C-u>"] = { "25k" },
    -- ["<C-f>"] = { "50j" },
    -- ["<C-b>"] = { "50k" },
    ["J"] = { "5j" },
    ["K"] = { "5k" },
    ["M"] = { "J" },
    ["<C-a>"] = { "0" },
    ["<C-e>"] = { "$" },
    ["<C-s>"] = { "^" },
    ["<C-t>"] = { "%" },
    ["gM"] = { "gM", desc = "Move to middle of line" },

    -- avoid mapping for <Tab> since the behavior will be changed with <C-i>
    -- ["<Tab>"] = { ">>" },
    -- ["<S-Tab>"] = { "<<" },

    -- delete single character without yanking into register
    ["x"] = { '"_x' },

    -- select all
    -- ["<A-a>"] = { "ggVG" },

    -- save without formatting
    ["<leader>W"] = { "<cmd>noa w<cr>", desc = "Save without formmating" },

    --  quit
    ["<leader>q"] = { "<cmd>confirm q<cr>", desc = "Quit" },
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

    -- tab
    ["<leader>c"] = { "<cmd>tabclose<cr>", desc = "Close tab" },

    -- manage buffers
    L = {
      function()
        require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1)
      end,
      desc = "Next buffer",
    },
    H = {
      function()
        require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1))
      end,
      desc = "Previous buffer",
    },
    ["<leader>x"] = {
      function()
        local bufs = vim.fn.getbufinfo({ buflisted = true })
        require("astronvim.utils.buffer").close(0)
        if require("astronvim.utils").is_available("alpha-nvim") and not bufs[2] then
          require("alpha").start(true)
        end
      end,
      desc = "Close buffer",
    },
    ["<leader>X"] = {
      function()
        local bufs = vim.fn.getbufinfo({ buflisted = true })
        require("astronvim.utils.buffer").close(0, true)
        if require("astronvim.utils").is_available("alpha-nvim") and not bufs[2] then
          require("alpha").start(true)
        end
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

    -- alpha
    ["<leader>a"] = {
      function()
        local wins = vim.api.nvim_tabpage_list_wins(0)
        if #wins > 1 and vim.api.nvim_get_option_value("filetype", { win = wins[1] }) == "neo-tree" then
          vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
        end
        require("alpha").start(false, require("alpha").default_config)
      end,
      desc = "Alpha dashboard",
    },

    -- terminal
    ["<leader>h"] = {
      function()
        require("astronvim.utils").toggle_term_cmd("lf")
      end,
      desc = "Toggle file manager",
    },
    ["<C-\\>"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle floating terminal" },
    ["<leader>Tl"] = {
      function()
        require("astronvim.utils").toggle_term_cmd("lazygit")
      end,
      desc = "ToggleTerm lazygit",
    },
    ["<leader>Td"] = {
      function()
        require("astronvim.utils").toggle_term_cmd("deno")
      end,
      desc = "ToggleTerm node",
    },
    ["<leader>Tn"] = {
      function()
        require("astronvim.utils").toggle_term_cmd("node")
      end,
      desc = "ToggleTerm node",
    },
    ["<leader>Tu"] = {
      function()
        require("astronvim.utils").toggle_term_cmd("ncdu")
      end,
      desc = "ToggleTerm ncdu",
    },
    ["<leader>Tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" },
    ["<leader>Th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" },
    ["<leader>Tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" },

    -- ui
    ["<leader>uo"] = { "<cmd>:silent !toggle_alacritty_opacity<cr>", desc = "Change terminal opacity" },

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
    ["<leader>jf"] = { "<cmd>HopWord<cr>", desc = "HopWord" },

    -- telescope
    ["<leader>fd"] = {
      function()
        require("telescope.builtin").diagnostics()
      end,
      desc = "Find diagnostics",
    },
    ["<leader>ff"] = {
      function()
        require("telescope.builtin").find_files({ hidden = true })
      end,
      desc = "Find files",
    },
    ["<leader>fF"] = {
      function()
        require("telescope.builtin").find_files({ hidden = true, no_ignore = true })
      end,
      desc = "Find all files",
    },
    ["<leader>fm"] = { "<cmd>Telescope vim_bookmarks current_file<cr>", desc = "Find bookmarks in current file" },
    ["<leader>fM"] = { "<cmd>Telescope vim_bookmarks all<cr>", desc = "Find all bookmarks" },
    ["<leader>fg"] = {
      function()
        require("telescope.builtin").registers()
      end,
      desc = "Find registers",
    },
    ["<leader>fr"] = {
      function()
        require("telescope.builtin").lsp_references()
      end,
      desc = "Find references of current symbol",
    },
    ["<leader>fs"] = { "<cmd>Telescope lsp_document_symbols<cr>", desc = "Find document symbols" },
    ["<leader>ft"] = { "<cmd>TodoTelescope<cr>", desc = "Find Todos" },
    ["<leader>fw"] = {
      function()
        require("telescope.builtin").live_grep({
          additional_args = function(args)
            return vim.list_extend(args, { "--hidden" })
          end,
        })
      end,
      desc = "Find words",
    },
    ["<leader>fW"] = {
      function()
        require("telescope.builtin").live_grep({
          additional_args = function(args)
            return vim.list_extend(args, { "--hidden", "--no-ignore" })
          end,
        })
      end,
      desc = "Find words in all files",
    },
    -- ["<leader>fW"] = {
    --   function()
    --     require("telescope").extensions.live_grep_args.live_grep_args({
    --       additional_args = function(args)
    --         return vim.list_extend(args, { "--hidden", "--no-ignore" })
    --       end,
    --     })
    --   end,
    --   desc = "Find words in all files",
    -- },
    ["<leader>f/"] = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Find words in current buffer" },

    -- lsp
    ["<leader>lRe"] = { "<cmd>!eslint_d restart<cr>", desc = "Restart eslint_d" },
    ["<leader>lRl"] = { "<cmd>LspRestart<cr>", desc = "Restart LSP" },
    ["<leader>lRp"] = { "<cmd>!prettierd flush-cache<cr>", desc = "Restart prettierd" },

    -- trouble
    ["<leader>tt"] = { "<cmd>TroubleToggle<cr>" },
    ["<leader>td"] = { "<cmd>TroubleToggle document_diagnostics<cr>" },
    ["<leader>tD"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>" },
    ["<leader>tq"] = { "<cmd>TroubleToggle quickfix<cr>" },
    ["<leader>tc"] = { "<cmd>TroubleToggle loclist<cr>" },
    ["<leader>tl"] = { "<cmd>TroubleToggle lsp_references<cr>" },
    ["gR"] = { "<cmd>TroubleToggle lsp_references<cr>" },

    -- git
    ["<leader>ga"] = { "<cmd>Telescope git_stash<CR>", desc = "Git stash" },
    ["<leader>gC"] = { "<cmd>Telescope git_bcommits<CR>", desc = "Git buffer commits" },
    ["<leader>gf"] = { "<cmd>DiffviewOpen<CR>", desc = "Open diffview" },
    ["[g"] = { "<cmd>lua require('gitsigns').prev_hunk()<cr>", desc = "Previous Git hunk" },
    ["]g"] = { "<cmd>lua require('gitsigns').next_hunk()<cr>", desc = "Next Git hunk" },
    ["<leader>gxc"] = { "<cmd>GitConflictChooseOurs<CR>", desc = "Git Conflict: Choose current" },
    ["<leader>gxi"] = { "<cmd>GitConflictChooseTheirs<CR>", desc = "Git Conflict: Choose incoming" },
    ["<leader>gxb"] = { "<cmd>GitConflictChooseBoth<CR>", desc = "Git Conflict: Choose both" },
    ["<leader>gxn"] = { "<cmd>GitConflictChooseNone<CR>", desc = "Git Conflict: Choose none" },
    ["<leader>gxl"] = { "<cmd>GitConflictListQf<CR>", desc = "Git Conflict: List of conflicts" },
    ["[x"] = { "<cmd>GitConflictPrevConflict<CR>", desc = "Git Conflict: Prev conflict" },
    ["]x"] = { "<cmd>GitConflictNextConflict<CR>", desc = "Git Conflict: Next conflict" },

    -- session manager
    ["<leader>rl"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" },
    ["<leader>rs"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save this session" },
    ["<leader>rd"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session" },
    ["<leader>rf"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" },
    ["<leader>r."] = { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" },

    -- textcase
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
    ["s"] = { "<Plug>Sneak_s" },
    ["S"] = { "<Plug>Sneak_S" },
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
    -- ["jj"] = { "<esc>" },

    -- cursor navigation
    -- ["<C-k>"] = { "<Up>" },
    ["<C-p>"] = { "<Up>" },
    -- ["<C-j>"] = { "<Down>" },
    ["<C-n>"] = { "<Down>" },
    ["<C-b>"] = { "<Left>" },
    -- ["<C-l>"] = { "<Right>" },
    ["<C-f>"] = { "<Right>" },
    ["<C-a>"] = { "<Esc>I" },
    ["<C-e>"] = { "<Esc>A" },
    ["<C-r>"] = { "<C-o>b" },
    ["<C-t>"] = { "<C-o>e" },
    -- ["<C-l>"] = { "<C-o>db" },
    ["<C-s>"] = { "<C-o>^" },
    ["<C-d>"] = { "<Del>" },
    ["<C-k>"] = { "<C-o>D" },
    -- ["<C-t>"] = { "<C-o>%" },

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

    ["w"] = { "iw" },

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
    ["w"] = { "aw" },
    -- ["t"] = { "at" },
    -- ["m"] = { "<Plug>CamelCaseMotion_ie" }, -- this operation is a bit slow thant mapping "dm" and "cm" respectively

    -- vim-sneak
    ["s"] = { "<Plug>Sneak_s" },
    ["S"] = { "<Plug>Sneak_S" },
    ["f"] = { "<Plug>Sneak_f" },
    ["F"] = { "<Plug>Sneak_F" },
    ["t"] = { "<Plug>Sneak_t" },
    ["T"] = { "<Plug>Sneak_T" },
  },
}
