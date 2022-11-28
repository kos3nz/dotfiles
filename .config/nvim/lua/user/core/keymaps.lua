-- Set up a bunch of different custom keybinds

local opts = { noremap = true, silent = true }
local cmd_opts = { noremap = true }

local map = vim.api.nvim_set_keymap -- for conciseness
local set = vim.keymap.set

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
map("n", "W", "*N", opts) -- search for word under cursor

-- delete single character without yanking into register
map("n", "x", '"_x', opts)

-- window management
map("n", "<C-h>", "<C-w><left>", opts) -- move between panes
map("n", "<C-l>", "<C-w><right>", opts)
map("n", "<C-k>", "<C-w><up>", opts)
map("n", "<C-j>", "<C-w><down>", opts)

map("n", "<A-Up>", ":resize +2<C-w>+", opts) -- resize pane
map("n", "<A-Down>", ":resize -2<CR>", opts)
map("n", "<A-Left>", ":vertical resize +2<CR>", opts)
map("n", "<A-Right>", ":vertical resize -2<CR>", opts)

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

-- bufferline (barbar)
-- move to previous/next
map("n", "<S-h>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<S-l>", "<Cmd>BufferNext<CR>", opts)
-- re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)
-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
-- Close buffer
map("n", "<A-w>", "<Cmd>BufferCloseAllButCurrentOrPinned<CR>", opts)
-- Wipeout buffer
--                 :BufferWipeout
-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight

-- vim-illuminate
map("n", "<C-[>", "<cmd>lua require('illuminate').goto_prev_reference()<cr>", opts)
map("n", "<C-]>", "<cmd>lua require('illuminate').goto_next_reference()<cr>", opts)

-- hlslens
map("n", "n", [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "N", [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "*", [[*<Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "#", [[#<Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "g*", [[g*<Cmd>lua require('hlslens').start()<CR>]], opts)
map("n", "g#", [[g#<Cmd>lua require('hlslens').start()<CR>]], opts)

-- todo comments
local todo_status, todo = pcall(require, "todo-comments")
if not todo_status then
  return
end

set("n", "]t", function()
  todo.jump_next()
end, { desc = "Next todo comment" })
set("n", "[t", function()
  todo.jump_prev()
end, { desc = "Previous todo comment" })
--
-- You can also specify a list of valid jump keywords
--
-- map("n", "]t", function()
--   todo.jump_next({keywords = { "ERROR", "WARNING" }})
-- end, { desc = "Next error/warning todo comment" })

-- hop
local hop_status, hop = pcall(require, "hop")
if not hop_status then
  return
end

local directions_status, directions = pcall(require, "hop.hint")
if not directions_status then
  return
end

set("n", "f", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, { remap = true })
set("n", "F", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, { remap = true })
set("n", "t", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
end, { remap = true })
set("n", "T", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
end, { remap = true })
