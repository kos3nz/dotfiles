return {
  "goolord/alpha-nvim",
  opts = function()
    local dashboard = require("alpha.themes.dashboard")
    local alpha_button = require("astronvim.utils").alpha_button

    dashboard.section.header.val = {
      "                                                     ",
      "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      "                                                     ",
    }
    dashboard.section.header.opts.hl = "DashboardHeader"

    dashboard.section.buttons.val = {
      alpha_button("LDR f f", "  Find File  "),
      alpha_button("LDR f o", "  Recent  "),
      alpha_button("LDR f w", "  Find Word  "),
      alpha_button("LDR f m", "  Bookmarks  "),
      alpha_button("LDR r f", "  Find Session  "),
      alpha_button("LDR r .", "  Last Session  "),
    }

    dashboard.section.footer.val =
      { " ", " ", " ", "AstroNvim loaded " .. require("lazy").stats().count .. " plugins " }
    dashboard.section.footer.opts.hl = "DashboardFooter"

    -- padding
    dashboard.config.layout[1].val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })
    dashboard.config.layout[3].val = 5

    dashboard.config.opts.noautocmd = true

    return dashboard
  end,
}
