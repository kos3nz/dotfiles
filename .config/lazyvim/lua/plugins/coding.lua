-- this function helps super tab work better
local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

return {
  -- auto completion
  {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "saadparwaiz1/cmp_luasnip",
    },
    opts = function()
      vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local defaults = require("cmp.config.default")()
      local border_opts = {
        border = "rounded",
        winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
      }

      return {
        completion = {
          completeopt = "menu,menuone,noselect",
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(border_opts),
          documentation = cmp.config.window.bordered(border_opts),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-5)),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(5)),
          ["<C-v>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<S-CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            -- elseif luasnip.expandable() then
            --   luasnip.expand()
            -- elseif luasnip.expand_or_jumpable() then
            --   luasnip.expand_or_jump()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(_, item)
            local icons = require("lazyvim.config").icons.kinds
            if icons[item.kind] then
              item.kind = icons[item.kind] .. item.kind
            end
            return item
          end,
        },
        experimental = {
          ghost_text = {
            hl_group = "CmpGhostText",
          },
        },
        sorting = defaults.sorting,
      }
    end,
    ---@param opts cmp.ConfigSchema
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      local cmp = require("cmp")

      -- run cmp setup
      cmp.setup(opts)

      -- Cmdline --
      -- configure mappings for cmdline
      local fallback_func = function(func)
        return function(fallback)
          if cmp.visible() then
            cmp[func]()
          else
            fallback()
          end
        end
      end
      local cmdline_mappings = cmp.mapping.preset.cmdline({
        ["<C-n>"] = { c = false },
        ["<C-p>"] = { c = false },
        ["<C-j>"] = { c = fallback_func("select_next_item") },
        ["<C-k>"] = { c = fallback_func("select_prev_item") },
        ["<C-v>"] = { c = fallback_func("complete") },
        ["<C-e>"] = { c = fallback_func("abort") },
        ["<CR>"] = { c = fallback_func("confirm") },
      })

      -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
      -- cmp.setup.cmdline("/", {
      --   mapping = cmdline_mappings,
      --   sources = {
      --     { name = "buffer" },
      --   },
      -- })
      -- cmp.setup.cmdline("?", {
      --   mapping = cmdline_mappings,
      --   sources = {
      --     { name = "buffer" },
      --   },
      -- })
      cmp.setup.cmdline(":", {
        mapping = cmdline_mappings,
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },

  -- comments
  {
    "echasnovski/mini.comment",
    enabled = false,
  },
  {
    "numToStr/Comment.nvim",
    event = "LazyFile", -- shortcut for event = { "BufReadPost", "BufWritePost", "BufNewFile" }, but defers (and re-triggers) the event to make sure the ui isn't blocked for initial rendering
    keys = {
      {
        "<c-_>",
        function()
          require("Comment.api").toggle.linewise.current()
        end,
        desc = "Toggle comment line",
        mode = { "n", "i" },
      },
      {
        "<c-_>",
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        desc = "Toggle comment line",
        mode = { "v", "x" },
      },
    },
    config = true, -- runs require('Comment').setup()
  },

  -- multi cursor
  {
    "mg979/vim-visual-multi",
    event = "LazyFile",
    init = function()
      vim.g.VM_maps = {
        ["Find Under"] = "<C-g>",
        ["Find Subword Under"] = "<C-g>",
        ["Select Cursor Down"] = "<C-n>",
        ["Select Cursor Up"] = "<C-p>",
      }
    end,
  },

  -- camel case motion
  {
    "bkad/CamelCaseMotion",
    event = "VeryLazy",
    init = function()
      vim.g.camelcasemotion_key = ","
    end,
    keys = {
      {
        "w",
        "<Plug>CamelCaseMotion_w",
        mode = { "n", "v", "x" },
      },
      {
        "e",
        "<Plug>CamelCaseMotion_e",
        mode = { "n", "v", "x" },
      },
      {
        "b",
        "<Plug>CamelCaseMotion_b",
        mode = { "n", "v", "x" },
      },
      {
        "m",
        "<Plug>CamelCaseMotion_ie",
        mode = { "o" },
      },
    },
  },

  -- replace with register
  {
    "vim-scripts/ReplaceWithRegister",
    event = "LazyFile",
    -- event = { "BufReadPre", "BufNewFile" },
  },
}
