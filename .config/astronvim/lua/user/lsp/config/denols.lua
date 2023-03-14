return function(opts)
  opts.root_dir = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")

  opts.init_options = {
    lint = true,
    unstable = true,
    suggest = {
      imports = {
        hosts = {
          ["https://deno.land"] = true,
          ["https://cdn.nest.land"] = true,
          ["https://crux.land"] = true,
        },
      },
    },
  }

  return opts
end
