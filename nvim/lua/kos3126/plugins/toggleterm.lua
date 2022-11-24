local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 1, -- the degree by which to darken to terminal color, default: 1 for dark background, 3 for light
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

-- function _G.set_terminal_keymaps()
--   local keymap = vim.keymap
--   local opts = { noremap = true }
--   keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
-- vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
-- vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
-- vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
-- vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
-- end

-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal
local gitui = Terminal:new({ cmd = "gitui", hidden = true })

function _GITUI_TOGGLE()
  gitui:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gu", "<cmd>lua _GITUI_TOGGLE()<CR>", { noremap = true, silent = true })

local deno = Terminal:new({ cmd = "deno", hidden = true })

function _DENO_TOGGLE()
  deno:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>de", "<cmd>lua _DENO_TOGGLE()<CR>", { noremap = true, silent = true })

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })

function _NCDU_TOGGLE()
  ncdu:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>nc", "<cmd>lua _NCDU_TOGGLE()<CR>", { noremap = true, silent = true })
