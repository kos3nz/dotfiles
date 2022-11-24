local options = {
  -- backup
  backup = false,                          -- creates a backup file
  swapfile = false,                        -- creates a swap file
  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

  -- line numbers
  number = true,                           -- who line numbers
  numberwidth = 2,                         -- set number column width to 2 (default 4)
  relativenumber = true,                   -- set relative numbered lines

  -- tabs & indentation
  tabstop = 2,                             -- insert 2 spaces for a tab
  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
  expandtab = true,                        -- convert tabs to spaces
  autoindent = true,                       -- copy indent from current line when starting new one
  smartindent = true,                      -- make indenting smarter again

  -- line wrapping
  wrap = false,                            -- display lines as one long line
  -- linebreak = false,                       -- companion to wrap, don't split words

  -- search settings
  hlsearch = true,                         -- highlight all matches on previous search pattern
  ignorecase = true,                       -- ignore case in search patterns
  smartcase = true,                        -- if you inclue mixed case in your search, neovim assumes you want case-sensitive

  -- mouse
  mouse = "a",                             -- allow the mouse to be used in neovim

  -- cursor line
  cursorline = true,                       -- highlight the current line

  -- appearance
  termguicolors = true,                    -- set term gui colors (most terminals supprt this)
  -- guifont = "monospace:h17",               -- the font used in graphical neovim applications
  showmode = false,                        -- not showing mode (such as -- INSERT -- at the bottom of screen)
  background = "dark",                     -- colorschemes that can be light or dark will be made dark
  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
  scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
  sidescrolloff = 8,                       -- minimal number of screen columns either side of cursor if wrap is `false`

  -- backspace
  backspace = "indent,eol,start",          -- allow backspace on indent, end of line or insert mode start position

  -- clipboard
  clipboard = 'unnamedplus',               -- use system clipboard as default register

  -- split windows
  splitbelow = true,                       -- split horizontal window to the bottom
  splitright = true,                       -- split vertical window to the right

  -- command line
  cmdheight = 1,                           -- space in the neovim command line for displaying messages

  -- cmp
  completeopt = { "menu", "menuone", "noselect" }, -- mostly just for cmp
  updatetime = 300,                        -- faster completion (4000ms default)

  -- pop up
  pumheight = 10,                          -- pop up menu height

  -- markdown
  conceallevel = 0,                        -- so that `` is visible in markdown files

  -- file
  fileencoding = "utf-8",                  -- the encoding written to a file
  undofile = true,                         -- enable persistent undo

  -- mapping
  timeoutlen = 500,                        -- time to wait for a mapped sequence to complete (in milliseconds)

  -- whichwrap = "bs<>[]hl",                  -- which "horizontal" keys are allowed to travel to prev/next line
}


local opt = vim.opt -- for conciseness

for k, v in pairs(options) do
  opt[k] = v
end


-- opt.shortmess = "ilmnrx"                           -- flags to shorten vim messages, see :help 'shortmess'
-- opt.shortmess:append "c"                           -- don't give |ins-completion-menu| messages
opt.iskeyword:append "-"                           -- hyphenated words recognized by searches
-- opt.formatoptions:remove({ "c", "r", "o" })        -- don't insert the current comment leader automatically for auto-wrapping comments using 'textwidth', hitting <Enter> in insert mode, or hitting 'o' or 'O' in normal mode.
-- opt.runtimepath:remove("/usr/share/vim/vimfiles")  -- separate vim plugins from neovim in case vim still in use
