return {
  "nvim-tree/nvim-web-devicons",
  config = function()
    require("nvim-web-devicons").setup({
      override = {
        deb = { icon = "", name = "Deb" },
        lock = { icon = "", name = "Lock" },
        mp3 = { icon = "", name = "Mp3" },
        mp4 = { icon = "", name = "Mp4" },
        out = { icon = "", name = "Out" },
        ["robots.txt"] = { icon = "ﮧ", name = "Robots" },
        ttf = { icon = "", name = "TrueTypeFont" },
        rpm = { icon = "", name = "Rpm" },
        woff = { icon = "", name = "WebOpenFontFormat" },
        woff2 = { icon = "", name = "WebOpenFontFormat2" },
        xz = { icon = "", name = "Xz" },
        zip = { icon = "", name = "Zip" },
      },
      -- globally enable different highlight colors per icon (default to true)
      -- if set to false all icons will have the default icon's color
      color_icons = true,
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = false,
      -- globally enable "strict" selection of icons - icon will be looked up in
      -- different tables, first by filename, and if not found by extension; this
      -- prevents cases when file doesn't have any extension but still gets some icon
      -- because its name happened to match some extension (default to false)
      strict = true,
      -- same as `override` but specifically for overrides by filename
      -- takes effect when `strict` is true
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore",
        },
        [".stylelintrc"] = {
          icon = "",
          color = "#f0f0f0",
          name = "Stylelint",
        },
        ["tailwind.config.js"] = {
          icon = "󱏿",
          color = "#38bdf8",
          name = "TailwindCSS",
        },
        ["tailwind.config.cjs"] = {
          icon = "󱏿",
          color = "#38bdf8",
          name = "TailwindCSS",
        },
        ["tsconfig.json"] = {
          icon = "󰛦",
          color = "#3b82f6",
          name = "TypescriptJSON",
        },
      },
      -- same as `override` but specifically for overrides by extension
      -- takes effect when `strict` is true
      override_by_extension = {
        ["astro"] = {
          icon = "",
          color = "#EC682C",
          name = "Astro",
        },
        ["log"] = {
          icon = "",
          color = "#81e043",
          name = "Log",
        },
        ["js"] = {
          icon = "", --  󰌞
          color = "#facc15",
          name = "Javascript",
        },
        ["cjs"] = {
          icon = "",
          color = "#facc15",
          name = "CommonJS",
        },
        ["mjs"] = {
          icon = "",
          color = "#facc15",
          name = "ESModules",
        },
        ["jsx"] = {
          icon = "", -- 󰜈,
          color = "#82D7F7",
          name = "JavascriptReact",
        },
        ["ts"] = {
          icon = "", -- ,󰛦
          color = "#3b82f6",
          name = "Typescript",
        },
        ["tsx"] = {
          icon = "",
          color = "#82D7F7",
          name = "TypescriptReact",
        },
        ["d.ts"] = {
          icon = "", -- ,󰛦
          color = "#3baa36",
          name = "Types",
        },
        ["sh"] = {
          icon = "",
          color = "#7dd3fc",
          name = "Shell",
        },
        ["zsh"] = {
          icon = "",
          color = "#428850",
          name = "Zsh",
        },
      },
    })
  end,
}
