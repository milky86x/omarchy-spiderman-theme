return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg = "#12131C",
        dark_bg = "#0D0E14",
        darker_bg = "#08080C",
        lighter_bg = "#181A26",

        fg = "#E1E1E6",
        dark_fg = "#44475A",
        light_fg = "#CFD2E0",
        bright_fg = "#FFFFFF",
        muted = "#44475A",

        red = "#E62429",
        yellow = "#F1FA8C",
        orange = "#FFB86C",
        green = "#50FA7B",
        cyan = "#8BE9FD",
        blue = "#6272A4",
        magenta = "#FF79C6",
        brown = "#C49A6C",

        bright_red = "#FF5555",
        bright_yellow = "#FFFFA5",
        bright_green = "#69FF94",
        bright_cyan = "#A4F4FF",
        bright_blue = "#BD93F9",
        bright_magenta = "#ff94d1",

        accent = "#E62429",
        cursor = "#FFFFFF",
        foreground = "#E1E1E6",
        background = "#12131C",
        selection = "#E62429",
        selection_foreground = "#FFFFFF",
        selection_background = "#E62429",
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "aether",
    },
  },
}
