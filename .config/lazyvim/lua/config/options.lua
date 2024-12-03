-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local g = vim.g

g.mapleader = " " -- sets vim.g.mapleader
g.autoformat_enabled = true -- enable or disable auto formatting at start (lsp.formatting.format_on_save must be enabled)
g.cmp_enabled = true -- enable completion at start
g.autopairs_enabled = true -- enable autopairs at start
g.diagnostics_enabled = true -- enable diagnostics at start
g.status_diagnostics_enabled = true -- enable diagnostics in statusline
g.icons_enabled = true -- disable icons in the UI (disable if no nerd font is available, requires :PackerSync after changing)
g.ui_notifications_enabled = true -- disable notifications when toggling UI elements

local opt = vim.opt

opt.spell = false -- sets vim.opt.spell

-- backup
opt.backup = false -- creates a backup file
opt.swapfile = false -- creates a swap file
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited

-- line numbers
opt.number = true -- who line numbers
opt.numberwidth = 4 -- set number column width (default 4)
opt.relativenumber = false -- set relative numbered lines

-- tabs & indentation
opt.tabstop = 2 -- insert 2 spaces for a tab
opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
opt.expandtab = true -- convert tabs to spaces
opt.autoindent = true -- copy indent from current line when starting new one
opt.smartindent = true -- make indenting smarter again

-- folding
-- opt.foldenable = true -- enable code folding
-- opt.foldmethod = "expr" -- specify an expression to define folds
-- opt.foldexpr = "nvim_treesitter#foldexpr()" -- enable syntax based code folding powered by Tree-sitter

-- line wrapping
opt.wrap = false -- display lines as one long line
-- opt.linebreak = false -- companion to wrap, don't split words

-- search settings
opt.hlsearch = true -- highlight all matches on previous search pattern
opt.ignorecase = true -- ignore case in search patterns
opt.smartcase = true -- if you inclue mixed case in your search, neovim assumes you want case-sensitive

-- mouse
opt.mouse = "a" -- allow the mouse to be used in neovim

-- cursor
opt.guicursor = "n-v-sm:block,c-i-ci-ve:ver25-blinkwait800-blinkoff1000-blinkon1000,r-cr:hor20,o:hor50"
opt.cursorline = true -- highlight the current line
opt.whichwrap = "hl" -- which "horizontal" keys are allowed to travel to prev/next line

-- appearance
opt.termguicolors = true -- set term gui colors (most terminals supprt this)
-- opt.guifont = "monospace:h17"               -- the font used in graphical neovim applications
opt.showmode = false -- not showing mode (such as -- INSERT -- at the bottom of screen)
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- always show the sign column, otherwise it would shift the text each time
opt.scrolloff = 8 -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 8 -- minimal number of screen columns either side of cursor if wrap is `false`

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard = "unnamedplus" -- use system clipboard as default register

-- split windows
opt.splitbelow = true -- split horizontal window to the bottom
opt.splitright = true -- split vertical window to the right

-- command line
opt.cmdheight = 1 -- space in the neovim command line for displaying messages

-- cmp
opt.completeopt = { "menu", "menuone", "noselect" } -- mostly just for cmp
opt.updatetime = 200 -- faster completion (4000ms default)

-- pop up
opt.pumheight = 10 -- pop up menu height

-- markdown
opt.conceallevel = 0 -- so that `` is visible in markdown files

-- file
opt.fileencoding = "utf-8" -- the encoding written to a file
opt.undofile = true -- enable persistent undo

-- mapping
opt.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds)
