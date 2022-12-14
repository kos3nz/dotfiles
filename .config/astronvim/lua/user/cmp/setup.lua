return function()
  -- load cmp to access it's internal functions
  local cmp = require("cmp")

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
  local mappings = cmp.mapping.preset.cmdline({
    ["<C-j>"] = { c = fallback_func("select_next_item") },
    ["<C-k>"] = { c = fallback_func("select_prev_item") },
  })
  local config = {
    -- configure cmp.setup.cmdline(source, options)
    cmdline = {
      -- first key is the source that you are setting up
      [":"] = {
        -- set up custom mappings
        mapping = mappings,
        -- configure sources normally without getting priority from cmp.source_priority
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      },
      ["/"] = { mapping = mappings, sources = { { name = "buffer" } } },
      ["?"] = { mapping = mappings, sources = { { name = "buffer" } } },
    },
  }
  -- return config
  return config
end
