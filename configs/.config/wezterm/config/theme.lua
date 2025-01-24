local wezterm = require("wezterm")

local module = {}

module.setup = function(config)
  config.term = "xterm-256color"

  config.animation_fps = 60
  config.max_fps = 60
  config.color_scheme = "Gruvbox dark, pale (base16)"

  config.font = wezterm.font("JetBrainsMono Nerd Font Propo")
  config.font_size = 9.5

  config.window_background_opacity = 1.0

  config.default_cursor_style = "BlinkingUnderline"
  config.cursor_blink_rate = 500

  config.colors = {
    background = "#282828",
    foreground = "#fbf1c7",

    ansi = { "#282828", "#cc241d", "#98971a", "#d79921", "#458588", "#b16286", "#689d6a", "#a89984" },
    brights = { "#928374", "#fb4934", "#b8bb26", "#fabd2f", "#83a598", "#d3869b", "#8ec07c", "#ebdbb2" },

    tab_bar = {
      background = "#282828",
      active_tab = {
        bg_color = "#585b70",
        fg_color = "#cdd6f4"
      },
      inactive_tab = {
        bg_color = "#313244",
        fg_color = "#45475a"
      },
      inactive_tab_hover = {
        bg_color = "#313244",
        fg_color = "#cdd6f4"
      },
      new_tab = {
        bg_color = "#1f1f28",
        fg_color = "#cdd6f4"
      },
      new_tab_hover = {
        bg_color = "#181825",
        fg_color = "#cdd6f4"
      },
    },
  }

  config.window_padding = {
    left = 5,
    right = 10,
    top = 12,
    bottom = 7,
  }

  config.inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.95,
  }
end

return module
