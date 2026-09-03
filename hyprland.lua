local active_border_color = "rgba(E62429ee)"
local inactive_border_color = "rgb(0D0E14)"

hl.config({
  general = {
    col = {
      active_border = active_border_color,
      inactive_border = inactive_border_color,
    },
  },
  group = {
    col = {
      border_active = active_border_color,
      border_inactive = inactive_border_color,
    },
  },
  decoration = {
    rounding = 8,
    rounding_power = 3,
  },
})
