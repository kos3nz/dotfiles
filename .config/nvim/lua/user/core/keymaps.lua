-- Set up a bunch of different custom keybinds

local opts = { noremap = true, silent = true }
local cmd_opts = { noremap = true }

local keymap = vim.keymap -- for conciseness

-- Remap space as leader key (default: backslash key)
keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
-- normal_mode = "n"
-- insert_mode = "i"
-- visual_mode = "v"
-- visual_block_mode = "x"
-- terminal_mode = "t"
-- command_mode = "c"

--------------------
-- Normal mode
--------------------

keymap.set("n", "<Enter>", "o<ESC>", opts) -- Insert new line below without going into insert mode
keymap.set("n", "<S-Enter>", "O<ESC>", opts) -- Insert new line above without going into insert mode

-- clear search highlight
keymap.set("n", "<leader>nh", ":nohl<CR>", opts)

-- delete single character without yanking into register
keymap.set("n", "x", '"_x', opts)

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", opts) -- increment
keymap.set("n", "<leader>-", "<C-x>", opts) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", opts) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", opts) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>", opts) -- close current split window

keymap.set("n", "<C-h>", "<C-w><left>", opts) -- move between panes
keymap.set("n", "<C-l>", "<C-w><right>", opts)
keymap.set("n", "<C-k>", "<C-w><up>", opts)
keymap.set("n", "<C-j>", "<C-w><down>", opts)

keymap.set("n", "<A-Up>", ":resize +2<CR>", opts) -- resize pane
keymap.set("n", "<A-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<A-Left>", ":vertical resize +2<CR>", opts)
keymap.set("n", "<A-Right>", ":vertical resize -2<CR>", opts)

-- tab management
keymap.set("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>", opts) -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>", opts) -- go to previous tab

-- move text up and down
keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)

--------------------
-- Insert mode
--------------------

keymap.set("i", "jj", "<ESC>", opts) -- go back to normal mode in insert mode

keymap.set("i", "<C-a>", "<ESC>I", opts) -- go to the beginning of the line
keymap.set("i", "<C-e>", "<ESC>A", opts) -- go to the end of the line

keymap.set("i", "<C-b>", "<Left>", opts)
keymap.set("i", "<C-j>", "<Down>", opts)
keymap.set("i", "<C-n>", "<Down>", opts)
keymap.set("i", "<C-k>", "<Up>", opts)
keymap.set("i", "<C-p>", "<Up>", opts)
keymap.set("i", "<C-l>", "<Right>", opts)
keymap.set("i", "<C-f>", "<Right>", opts)

-- move text up and down
keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)

--------------------
-- Visual mode
--------------------

-- stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- move text up and down
keymap.set("v", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("v", "<A-k>", ":m .-2<CR>==", opts)

keymap.set("v", "p", '"_dP', opts)

--------------------
-- Visual Block
--------------------

-- move text up and down
keymap.set("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap.set("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--------------------
-- Command mode
--------------------

keymap.set("c", "<C-a>", "<S-Left>", cmd_opts)
keymap.set("c", "<C-e>", "<S-Right>", cmd_opts)

keymap.set("c", "<C-j>", "<Down>", cmd_opts)
keymap.set("c", "<C-k>", "<Up>", cmd_opts)
keymap.set("c", "<C-b>", "<Left>", cmd_opts)
keymap.set("c", "<C-l>", "<Right>", cmd_opts)
keymap.set("c", "<C-f>", "<Right>", cmd_opts)

--------------------
-- Plugin keymap
--------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- maximize the size of the window
