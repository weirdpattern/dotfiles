local wezterm = require("wezterm")

local action = wezterm.action
local platform = wezterm.target_triple

local module = {}

module.SUPER = platform:find("windows") and "ALT" or "SUPER"
module.COMMAND = platform:find("windows") and "CTRL" or "SUPER"

local smart_split = wezterm.action_callback(function(window, pane)
  local dimension = pane:get_dimensions()

  if dimension.pixel_height > dimension.pixel_width then
    window:perform_action(action.SplitVertical({ domain = "CurrentPaneDomain" }))
  else
    window:perform_action(action.SplitHorizontal({ domain = "CurrentPaneDomain" }))
  end
end)

module.setup = function(config)
  config.disable_default_key_bindings = true

  config.leader = {
    key = "Space",
    mods = "CTRL"
  }

  config.keys = {
    { key = "c", mods = "CTRL", action = action.CopyTo("Clipboard") },
    { key = "v", mods = "CTRL", action = action.PasteFrom("Clipboard") },
    { key = "z", mods = "CTRL", action = action.SendKey({ key = "z", mods = module.COMMAND }) },
    { key = "y", mods = "CTRL", action = action.SendKey({ key = "y", mods = module.COMMAND }) },
    { key = "Home", action = action.SendString("\001") },
    { key = "End", action = action.SendString("\005") },
    { key = "LeftArrow", mods = module.SUPER, action = action.SendString("\x1bb") },
    { key = "RightArrow", mods = module.SUPER, action = action.SendString("\x1bf") },
    { key = "t", mods = "CTRL", action = action.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS" }) },
    { key = "Enter", mods = "LEADER", action = smart_split },
    {
      key = "w",
      mods = "LEADER",
      action = action.ActivateKeyTable({ name = "windows", one_shot = false, timeout_milliseconds = 2000 })
    },
    {
      key = '.',
      mods = 'LEADER',
      action = action.PromptInputLine {
        description = 'Enter new name for tab',
        action = wezterm.action_callback(
          function(window, pane, line)
            if line then
              window:active_tab():set_title(line)
            end
          end
        )
      }
    }
  }

  config.key_tables = {
    windows = {
      { key = "q", action = action.CloseCurrentPane({ confirm = false }) },
      { key = "h", action = action.ActivatePaneDirection("Left") },
      { key = "j", action = action.ActivatePaneDirection("Down") },
      { key = "k", action = action.ActivatePaneDirection("Up") },
      { key = "l", action = action.ActivatePaneDirection("Right") },
      { key = "Tab", action = action.ActivatePaneDirection("Next") },
      { key = "PageUp", action = action.RotatePanes("Clockwise") },
      { key = "PageDown", action = action.RotatePanes("CounterClockwise") },
      { key = "Home", action = action.PaneSelect({ mode = "SwapWithActive" }) },
      { key = "v", action = action.SplitVertical({ domain = "CurrentPaneDomain" }) },
      { key = "s", action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
      { key = "<", action = action.AdjustPaneSize({ "Left", 1 }) },
      { key = "-", action = action.AdjustPaneSize({ "Down", 1 }) },
      { key = "+", action = action.AdjustPaneSize({ "Up", 1 }) },
      { key = ">", action = action.AdjustPaneSize({ "Right", 1 }) },
      { key = "Escape", action = action.PopKeyTable }
    }
  }

  for i = 0, 9 do
    table.insert(config.keys, {
      key = tostring(i),
      mods = "LEADER",
      action = action.ActivateTab(i)
    })
  end
end

return module
