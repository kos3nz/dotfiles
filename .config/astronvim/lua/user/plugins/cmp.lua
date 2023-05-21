local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "פּ",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

-- this function helps super tab work better
local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

return {
  "hrsh7th/nvim-cmp",
  keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
  dependencies = {
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-nvim-lua",
  },
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    opts.formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        local shorten_abbr = string.sub(vim_item.abbr, 1, 30)
        if shorten_abbr ~= vim_item.abbr then
          vim_item.abbr = shorten_abbr .. "..."
        end

        -- Kind icons
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        -- vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)

        -- Source
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          nvim_lua = "[Lua]",
          luasnip = "[LuaSnip]",
          buffer = "[Buf]",
          path = "[Path]",
          -- cmp_tabnine = "[Tabnine]",
          -- emoji = "[Emoji]",
        })[entry.source.name]

        return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
      end,
    }

    opts.mapping = {
      ["<C-k>"] = cmp.mapping.select_prev_item(),
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-j>"] = cmp.mapping.select_next_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
      ["<C-v>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- show suggestion window
      ["<C-l>"] = cmp.mapping.abort(), -- close suggestion window
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
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
      end, {
        "i",
        "s",
      }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.locally_jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, {
        "i",
        "s",
      }),
    }
    -- modify the sources part of the options table
    opts.sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 1000 },
      { name = "luasnip", priority = 900 },
      { name = "nvim_lua", priority = 800 },
      { name = "buffer", priority = 500 },
      { name = "path", priority = 250 },
    })

    opts.experimental = {
      ghost_text = true,
      native_menu = false,
    }

    return opts
  end,
  config = function(_, opts)
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
      ["<C-j>"] = { c = fallback_func("select_next_item") },
      ["<C-k>"] = { c = fallback_func("select_prev_item") },
    })

    -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
    cmp.setup.cmdline("/", {
      mapping = cmdline_mappings,
      sources = {
        { name = "buffer" },
      },
    })
    cmp.setup.cmdline("?", {
      mapping = cmdline_mappings,
      sources = {
        { name = "buffer" },
      },
    })
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
}
