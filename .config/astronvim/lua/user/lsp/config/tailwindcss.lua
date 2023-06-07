return {
  filetypes = {
    "html",
    "css",
    "scss",
    "less",
    "javascriptreact",
    "typescriptreact",
    "svelte",
    "vue",
    "astro",
  },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
      experimental = {
        classRegex = {
          {
            "tw`([^`]*)", -- tw`...`
            'tw="([^"]*)', -- <div tw="..." />
            'tw={"([^"}]*)', -- <div tw={"..."} />
            "tw\\.\\w+`([^`]*)", -- tw.xxx`...`
            "tw\\(.*?\\)`([^`]*)", -- tw(Component)`...`
            "cva\\(([^)]*)\\)", -- support for cva
            "[\"'`]([^\"'`]*).*?[\"'`]",
          },
        },
      },
    },
  },
}
