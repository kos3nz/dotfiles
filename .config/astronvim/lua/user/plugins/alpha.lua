return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local alpha_button = require("astronvim.utils").alpha_button

    opts.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }
    opts.section.header.opts.hl = "DashboardHeader"

    opts.section.buttons = {
      val = {
        alpha_button("LDR f f", "  Find File  "),
        alpha_button("LDR f o", "  Recent  "),
        alpha_button("LDR f w", "  Find Word  "),
        alpha_button("LDR f m", "  Bookmarks  "),
        alpha_button("LDR r f", "  Find Session  "),
        alpha_button("LDR r .", "  Last Session  "),
      },
      opts = { spacing = 1 },
    }

    opts.section.footer.val = { " ", " ", " ", "AstroNvim loaded " .. require("lazy").stats().count .. " plugins " }
    opts.section.footer.opts.hl = "DashboardFooter"

    -- padding
    opts.config.layout[1].val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })
    opts.config.layout[3].val = 5

    opts.config.opts.noautocmd = true

    return opts
  end,
}
