-- set vim options here (vim.<first_key>.<second_key> = value)
return {
  opt = {
    -- spelling
    spell = false, -- sets vim.opt.spell

    -- backup
    backup = false, -- creates a backup file
    swapfile = false, -- creates a swap file
    writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

    -- line numbers
    number = true, -- who line numbers
    numberwidth = 2, -- set number column width to 2 (default 4)
    relativenumber = false, -- set relative numbered lines

    -- tabs & indentation
    tabstop = 2, -- insert 2 spaces for a tab
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    expandtab = true, -- convert tabs to spaces
    autoindent = true, -- copy indent from current line when starting new one
    smartindent = true, -- make indenting smarter again

    -- line wrapping
    wrap = false, -- display lines as one long line
    -- linebreak = false, -- companion to wrap, don't split words

    -- search settings
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    smartcase = true, -- if you inclue mixed case in your search, neovim assumes you want case-sensitive

    -- mouse
    mouse = "a", -- allow the mouse to be used in neovim

    -- cursor
    guicursor = "n-v-sm:block,c-i-ci-ve:ver25-blinkwait800-blinkoff1000-blinkon1000,r-cr:hor20,o:hor50",
    cursorline = true, -- highlight the current line
    whichwrap = "hl", -- which "horizontal" keys are allowed to travel to prev/next line

    -- appearance
    termguicolors = true, -- set term gui colors (most terminals supprt this)
    -- guifont = "monospace:h17",               -- the font used in graphical neovim applications
    showmode = false, -- not showing mode (such as -- INSERT -- at the bottom of screen)
    background = "dark", -- colorschemes that can be light or dark will be made dark
    signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
    scrolloff = 8, -- minimal number of screen lines to keep above and below the cursor
    sidescrolloff = 8, -- minimal number of screen columns either side of cursor if wrap is `false`

    -- backspace
    backspace = "indent,eol,start", -- allow backspace on indent, end of line or insert mode start position

    -- clipboard
    clipboard = "unnamedplus", -- use system clipboard as default register

    -- split windows
    splitbelow = true, -- split horizontal window to the bottom
    splitright = true, -- split vertical window to the right

    -- command line
    cmdheight = 1, -- space in the neovim command line for displaying messages

    -- cmp
    completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
    updatetime = 300, -- faster completion (4000ms default)

    -- pop up
    pumheight = 10, -- pop up menu height

    -- markdown
    conceallevel = 0, -- so that `` is visible in markdown files

    -- file
    fileencoding = "utf-8", -- the encoding written to a file
    undofile = true, -- enable persistent undo

    -- mapping
    timeoutlen = 250, -- time to wait for a mapped sequence to complete (in milliseconds)
  },

  g = {
    mapleader = " ", -- sets vim.g.mapleader
    autoformat_enabled = true, -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
    cmp_enabled = true, -- enable completion at start
    autopairs_enabled = true, -- enable autopairs at start
    diagnostics_enabled = true, -- enable diagnostics at start
    status_diagnostics_enabled = true, -- enable diagnostics in statusline
    icons_enabled = true, -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
    ui_notifications_enabled = true, -- disable notifications when toggling UI elements

    -- vim-visual-multi mappings
    VM_maps = {
      ["Find Under"] = "<C-g>",
      ["Find Subword Under"] = "<C-g>",
      ["Select Cursor Down"] = "<C-n>",
      ["Select Cursor Up"] = "<C-p>",
      -- ["Mouse Cursor"] = "<C-LeftMouse>",
      -- ["Mouse Word"] = "<C-RightMouse>",
    },

    camelcasemotion_key = ",",
  },
}

-- If you need more control, you can use the function()...end notation
-- options = function(local_vim)
--   local_vim.opt.relativenumber = true
--   local_vim.g.mapleader = " "
--   local_vim.opt.whichwrap = vim.opt.whichwrap - { 'b', 's' } -- removing option from list
--   local_vim.opt.shortmess = vim.opt.shortmess + { I = true } -- add to option list
--
--   return local_vim
-- end,
