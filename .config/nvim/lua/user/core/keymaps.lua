-- Set up a bunch of different custom keybinds

local opts = { noremap = true, silent = true }
local cmd_opts = { noremap = true }

local map = vim.api.nvim_set_keymap -- for conciseness

-- Remap space as leader key (default: backslash key)
map("", "<Space>", "<Nop>", opts)
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

map("n", "<Enter>", "o<ESC>", opts) -- Insert new line below without going into insert mode
map("n", "<S-Enter>", "O<ESC>", opts) -- Insert new line above without going into insert mode

-- search
map("n", "<leader>nh", ":nohl<CR>", opts) -- clear search highlight
map("n", "W", "*N", opts) -- search for word under cursor

-- delete single character without yanking into register
map("n", "x", '"_x', opts)

-- increment/decrement numbers
map("n", "<leader>+", "<C-a>", opts) -- increment
map("n", "<leader>-", "<C-x>", opts) -- decrement

-- window management
map("n", "<leader>sv", "<C-w>v", opts) -- split window vertically
map("n", "<leader>sh", "<C-w>s", opts) -- split window horizontally
map("n", "<leader>se", "<C-w>=", opts) -- make split windows equal width
map("n", "<leader>sx", ":close<CR>", opts) -- close current split window

map("n", "<C-h>", "<C-w><left>", opts) -- move between panes
map("n", "<C-l>", "<C-w><right>", opts)
map("n", "<C-k>", "<C-w><up>", opts)
map("n", "<C-j>", "<C-w><down>", opts)

map("n", "<A-Up>", ":resize +2<CR>", opts) -- resize pane
map("n", "<A-Down>", ":resize -2<CR>", opts)
map("n", "<A-Left>", ":vertical resize +2<CR>", opts)
map("n", "<A-Right>", ":vertical resize -2<CR>", opts)

-- tab management
map("n", "<leader>to", ":tabnew<CR>", opts) -- open new tab
map("n", "<leader>tx", ":tabclose<CR>", opts) -- close current tab
map("n", "<leader>tn", ":tabn<CR>", opts) -- go to next tab
map("n", "<leader>tp", ":tabp<CR>", opts) -- go to previous tab

-- move text up and down
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)

--------------------
-- Insert mode
--------------------

map("i", "jj", "<ESC>", opts) -- go back to normal mode in insert mode

map("i", "<C-a>", "<ESC>I", opts) -- go to the beginning of the line
map("i", "<C-e>", "<ESC>A", opts) -- go to the end of the line

map("i", "<C-b>", "<Left>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-n>", "<Down>", opts)
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-p>", "<Up>", opts)
map("i", "<C-l>", "<Right>", opts)
map("i", "<C-f>", "<Right>", opts)

-- move text up and down
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)

--------------------
-- Visual mode
--------------------

-- stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- move text up and down
map("v", "<A-j>", ":m .+1<CR>==", opts)
map("v", "<A-k>", ":m .-2<CR>==", opts)

map("v", "p", '"_dP', opts)

--------------------
-- Visual Block
--------------------

-- move text up and down
map("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
map("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

--------------------
-- Command mode
--------------------

map("c", "<C-a>", "<S-Left>", cmd_opts)
map("c", "<C-e>", "<S-Right>", cmd_opts)

map("c", "<C-j>", "<Down>", cmd_opts)
map("c", "<C-k>", "<Up>", cmd_opts)
map("c", "<C-b>", "<Left>", cmd_opts)
map("c", "<C-l>", "<Right>", cmd_opts)
map("c", "<C-f>", "<Right>", cmd_opts)

--------------------
-- Plugin keymap
--------------------

-- vim-maximizer
map("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- maximize the size of the window

-- nvim-tree
map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
map("n", "<leader>cl", ":NvimTreeCollapse<CR>", opts)

-- bufferline (barbar)
-- move to previous/next
map("n", "<S-h>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<S-l>", "<Cmd>BufferNext<CR>", opts)
-- re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- go to buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)
-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
map("n", "<leader>w", "<Cmd>BufferClose<CR>", opts)
map("n", "<A-w>", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight
-- Magic buffer-picking mode
map("n", "<leader>bp", "<Cmd>BufferPick<CR>", opts)
-- Sort automatically by...
map("n", "<leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", opts)
map("n", "<leader>bd", "<Cmd>BufferOrderByDirectory<CR>", opts)
map("n", "<leader>bl", "<Cmd>BufferOrderByLanguage<CR>", opts)
map("n", "<leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", opts)

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts) -- find files within current working directory, respects .gitignore
map("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", opts) -- find string in current working directory as you type
map("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", opts) -- find string under cursor in current working directory
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts) -- list open buffers in current neovim instance
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", opts) -- list available help tags

map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", opts) -- list all git commits (use <cr> to checkout) ["gc" stands for git commits]
map("n", "<leader>gfc", "<cmd>Telescope git_bcommits<CR>", opts) -- list git commits for current file/buffer (use <cr> to checkout) ["gfc" stands for git file commits]
map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", opts) -- list git branches (use <cr> to checkout) ["gb" stands for git branch]
map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", opts) -- list current changes per file with diff preview ["gs" stands for git status]
map("n", "<leader>gt", "<cmd>Telescope git_stash<CR>", opts) -- lists stash items in current repository with ability to apply them on <cr>

-- gitsings
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", opts) -- preview the diff of the line
map("n", "<leader>gr", ":Gitsigns reset_hunk<CR>", opts) -- reset changes of the line
map("n", "<leader>gl", ":Gitsigns blame_line<CR>", opts) -- see auther, timeline, and commit message under cursor

-- todo comments
local todo_status, todo = pcall(require, "todo-comments")
if not todo_status then
  return
end

vim.keymap.set("n", "]t", function()
  todo.jump_next()
end, { desc = "Next todo comment" })
vim.keymap.set("n", "[t", function()
  todo.jump_prev()
end, { desc = "Previous todo comment" })
--
-- You can also specify a list of valid jump keywords
--
-- map("n", "]t", function()
--   todo.jump_next({keywords = { "ERROR", "WARNING" }})
-- end, { desc = "Next error/warning todo comment" })
