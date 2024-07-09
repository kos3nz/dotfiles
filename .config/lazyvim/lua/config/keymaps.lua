-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set
local del = vim.keymap.del

--------------------
-- Normal mode
--------------------
local n = "n"

map(n, "J", "6j")
map(n, "K", "5k")
map(n, "M", "J")
map(n, "<c-a>", "0")
map(n, "<c-e>", "$")
-- map(n, "<c-s>", "^")
map(n, "<c-t>", "%")
map(n, "gM", "gM", { desc = "Move to middle of line" })
map(n, "<enter>", "o<esc>", { desc = "Insert new line below" })
map(n, "<s-enter>", "O<esc>", { desc = "Insert new line above" })
map(n, "gu", "gu", { desc = "To lower case" })
map(n, "gU", "gU", { desc = "To Upper case" })
map(n, "g~", "g~", { desc = "Switch case" })
map(n, "x", '"_x') -- delete single character without yanking into register

-- window management
map("n", "<c-w>d", "<C-W>c", { desc = "Delete window" })
map("n", "<c-w>h", "<C-W>s", { desc = "Split window below" })
map("n", "<c-w>-", "<C-W>s", { desc = "Split window below" })
map("n", "<c-w>|", "<C-W>v", { desc = "Split window right" })

map(n, "<leader>qw", "<cmd>close<cr>", { desc = "Close Window" })
map(n, "<leader>qq", "<cmd>confirm qa<cr>", { desc = "Quit" })

map(n, "<leader>ik", ":m .-2<cr>==", { desc = "Move text up", silent = true })
map(n, "<leader>ij", ":m .+1<cr>==", { desc = "Move text down", silent = true })

-- Disable mappings
del("n", "<leader>ww")
del("n", "<leader>wd")
del("n", "<leader>w-")
del("n", "<leader>w|")
del("n", "<leader>ft")
del("n", "<leader>fT")

--------------------
-- Insert mode
--------------------
local i = "i"

map(i, "<c-p>", "<up>")
map(i, "<c-n>", "<down>")
map(i, "<c-b>", "<c-o>h")
map(i, "<c-f>", "<c-o>l")
map(i, "<c-a>", "<c-o>I")
map(i, "<c-e>", "<c-o>A")
map(i, "<c-s>", "<c-o>^")
map(i, "<c-t>", "<c-o>e")
map(i, "<c-r>", "<c-o>b")
map(i, "<c-d>", "<del>")
map(i, "<c-k>", "<c-o>D")

--------------------
-- Visual / Visual Block mode
--------------------
local v = "v"
local x = "x"

-- stay in indent mode
map({ v, x }, ">", ">gv")
map({ v, x }, "<", "<gv")
map({ v, x }, "<tab>", ">gv")
map({ v, x }, "<s-tab>", ">gv")

-- cursor navigation
map({ v, x }, "J", "5j")
map({ v, x }, "K", "5k")
map({ v, x }, "<c-a>", "0")
map({ v, x }, "<c-e>", "$")
map({ v, x }, "<c-s>", "^")
map({ v, x }, "<c-t>", "%")

-- move text up and down
map({ v, x }, "<leader>ik", ":m '<-2<cr>gv=gv", { desc = "Move text up", silent = true })
map({ v, x }, "<leader>ij", ":m '>+1<cr>gv=gv", { desc = "Move text down", silent = true })

-- CamelCaseMotion
-- ["m"] = { "<Plug>CamelCaseMotion_ie" },

--------------------
-- Command mode
--------------------
local c = "c"

map(c, "<c-p>", "<up>")
-- map(c, "<c-k>", "<up>")
-- map(c, "<c-j>", "<down>")
map(c, "<c-n>", "<down>")
map(c, "<c-b>", "<left>")
map(c, "<c-f>", "<right>")
map(c, "<c-l>", "<right>")
map(c, "<c-h>", "<bs>")
map(c, "<c-a>", "<s-left>")
map(c, "<c-e>", "<s-right>")

--------------------
-- Terminal mode
--------------------
local t = "t"

map(t, "<c-p>", "<up>")
map(t, "<c-j>", "<down>")
map(t, "<c-n>", "<down>")
map(t, "<c-b>", "<left>")
map(t, "<c-f>", "<right>")
map(t, "<c-h>", "<bs>")

del(t, "<c-k>")
del(t, "<c-l>")

--------------------
-- Operator pending mode
--------------------
local o = "o"

map(o, "w", "aw")
