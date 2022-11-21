-- Set up a bunch of different custom keybinds

vim.g.mapleader = " " -- set <leader> key to space key (default: backslash key)

local keymap = vim.keymap -- for conciseness

-- general keymaps
-- "n"=normal mode, "i"=insert mode, "v"=visual mode, "c"=command mode

-- Example
keymap.set("i", "jk", "<ESC>") -- In insert mode, typing "jk" equals to hit <ESC> (go back to normal mode)

--------------------
-- Normal mode
--------------------

keymap.set("n", "<Enter>", "o<ESC>") -- Insert new line below without going into insert mode
keymap.set("n", "<S-Enter>", "O<ESC>") -- Insert new line above without going into insert mode

-- clear search highlight
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without yanking into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<C-h>", "<C-w><left>") -- move between panes
keymap.set("n", "<C-l>", "<C-w><right>")
keymap.set("n", "<C-k>", "<C-w><up>")
keymap.set("n", "<C-j>", "<C-w><down>")

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

--------------------
-- Insert mode
--------------------

keymap.set("i", "<C-a>", "<ESC>I") -- go to the beginning of the line
keymap.set("i", "<C-e>", "<ESC>A") -- go to the end of the line

keymap.set("i", "<C-b>", "<Left>")
keymap.set("i", "<C-j>", "<Down>")
keymap.set("i", "<C-n>", "<Down>")
keymap.set("i", "<C-k>", "<Up>")
keymap.set("i", "<C-p>", "<Up>")
keymap.set("i", "<C-l>", "<Right>")
keymap.set("i", "<C-f>", "<Right>")

--------------------
-- Command mode
--------------------

keymap.set("c", "<C-a>", "<S-Left>")
keymap.set("c", "<C-e>", "<S-Right>")

keymap.set("c", "<C-j>", "<Down>")
keymap.set("c", "<C-k>", "<Up>")
keymap.set("c", "<C-b>", "<Left>")
keymap.set("c", "<C-l>", "<Right>")
keymap.set("c", "<C-f>", "<Right>")

--------------------
-- Plugin keymaps
--------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- maximize the size of the window

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

-- telescope git commands
keymap.set("n", "<leader>gc", "<cmd>Telescope git_commits<cr>") -- list all git commits (use <cr> to checkout) ["gc" stands for git commits]
keymap.set("n", "<leader>gfc", "<cmd>Telescope git_bcommits<cr>") -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" stands for git file commits]
keymap.set("n", "<leader>gb", "<cmd>Telescope git_branches<cr>") -- list git branches (use <cr> to checkout) ["gb" stands for git branch]
keymap.set("n", "<leader>gs", "<cmd>Telescope git_status<cr>") -- list current changes per file with diff preview ["gs" stands for git status]

-- restart lsp server
keymap.set("n", "<leader>rs", ":LspRestart<CR>") -- mapping to restart lsp if necessary
