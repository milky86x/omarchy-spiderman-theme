return {
  {
    "bjarneo/aether.nvim",
    branch = "v3",
    name = "aether",
    priority = 1000,
    opts = {
      colors = {
        bg = "#0B1120",
        dark_bg = "#080D1A",
        darker_bg = "#05080F",
        lighter_bg = "#1B2A44",

        fg = "#F5F7FF",
        dark_fg = "#5A6789",
        light_fg = "#C8D1E8",
        bright_fg = "#FFFFFF",
        muted = "#4A5678",

        red = "#E50914",
        yellow = "#F0C674",
        orange = "#E05A2A",
        green = "#7DBF46",
        cyan = "#5BC8F0",
        blue = "#3D5A9E",
        magenta = "#B48EAD",
        brown = "#8A6D3B",

        bright_red = "#FF2D39",
        bright_yellow = "#FFD787",
        bright_green = "#9CCC65",
        bright_cyan = "#80DEEA",
        bright_blue = "#5E83CE",
        bright_magenta = "#D39BC6",

        accent = "#E50914",
        cursor = "#FFFFFF",
        foreground = "#F5F7FF",
        background = "#0B1120",
        selection = "#242F4D",
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