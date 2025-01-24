local wezterm = require("wezterm")
local action = wezterm.action

local module = {}

module.setup = function(config)
  config.alternate_buffer_wheel_scroll_speed = 1
  config.bypass_mouse_reporting_modifiers = "CTRL"

  config.mouse_bindings = {
    {
      event = { Up = { streak = 1, button = "Left" } },
      action = action.CompleteSelection("Clipboard")
    },

    {
      event = { Up = { streak = 1, button = "Left" } },
      mods = "CTRL",
      action = action.CompleteSelectionOrOpenLinkAtMouseCursor("ClipboardAndPrimarySelection")
    },

    {
      event = { Up = { streak = 2, button = 'Left' } },
      action = action.SelectTextAtMouseCursor("SemanticZone")
    }
  }
end

return module
