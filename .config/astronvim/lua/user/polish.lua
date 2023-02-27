-- This function is run last and is a good place to configuring
-- augroups/autocommands and custom filetypes also this just pure lua so
-- anything that doesn't fit in the normal config locations above can go here

return function()
  -- vim.api.nvim_create_augroup("packer_conf", { clear = true })
  -- vim.api.nvim_create_autocmd("BufWritePost", {
  --   desc = "Sync packer after modifying plugins.lua",
  --   group = "packer_conf",
  --   pattern = "plugins.lua",
  --   command = "source <afile> | PackerSync",
  -- })

  local create_autocmd = vim.api.nvim_create_autocmd
  -- local create_user_command = vim.api.nvim_create_user_command

  vim.opt.iskeyword:append("-") -- hyphenated words recognized by searches

  -- when creating or reading text file, enable spell checking
  create_autocmd({ "BufRead", "BufNewFile" }, { pattern = { "*.txt", "*.md", "*.text" }, command = "setlocal spell" })

  -- when creating or reading files matched with patterns specified below, set filetype to jsonc
  create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = {
      "settings.json",
      "keybindings.json",
      "**/snippets/*.json",
      "**/snippets/*.code-snippets",
      "tsconfig.json",
    },
    command = "setlocal filetype=jsonc",
  })

  -- when reading any files, open all folds
  -- create_autocmd({ "BufReadPost", "FileReadPost" }, { pattern = { "*" }, command = "normal zR" })

  -- create_user_command(
  --   "BufferCloseAllButCurrent",
  --   Close_all_but_current,
  --   { desc = "Close every buffer except the current one" }
  -- )

  -- Define global functions --

  function Close_all_but_current(force)
    if force == nil then
      force = false
    end

    local current = vim.api.nvim_get_current_buf()
    local buffers = vim.api.nvim_list_bufs()
    local buf_get_option = vim.api.nvim_buf_get_option

    for _, bufnr in ipairs(buffers) do
      if buf_get_option(bufnr, "buflisted") then
        if bufnr ~= current then
          if astronvim.is_available("bufdelete.nvim") then
            require("bufdelete").bufdelete(bufnr, force)
          else
            vim.cmd((force and "bd!" or "confirm bd") .. bufnr)
          end
        end
      end
    end
  end
end
