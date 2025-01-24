local wezterm = require("wezterm")

local module = {}

module.setup = function(config)
  config.tab_max_width = 32

  config.hide_tab_bar_if_only_one_tab = false
  config.tab_bar_at_bottom = true
  config.use_fancy_tab_bar = false
  config.tab_and_split_indices_are_zero_based = true

  config.switch_to_last_active_tab_when_closing_tab = true

  config.window_decorations = "TITLE|RESIZE"
  config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0
  }

  wezterm.on("update-status", function(window)
    local PREFIX = ""

    if window:leader_is_active() then
      PREFIX = " " .. utf8.char(0x026A1)
    end

    window:set_left_status(wezterm.format({
      { Background = { Color = "#ee4b2b" } },
      { Text = PREFIX },
      ARROW_FOREGROUND,
      { Text = SOLID_LEFT_ARROW }
    }))
  end)
end

return module
