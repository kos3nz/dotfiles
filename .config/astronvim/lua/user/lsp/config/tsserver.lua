return function(opts)
  opts.root_dir = require("lspconfig.util").root_pattern("package.json")

  opts.single_file_support = false

  return opts
end
