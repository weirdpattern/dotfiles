local wezterm = require("wezterm")

local module = {}

local function set_left_status(window)
  local BACKGROUND = "#000000";

  if window:leader_is_active() then
    BACKGROUND = "#d65d0e"
  elseif window:active_key_table() then
    BACKGROUND = "#689d6a"
  end

  window:set_left_status(wezterm.format({
    { Background = { Color = BACKGROUND } },
    { Text = " " .. utf8.char(0x026A1) }
  }))
end

local function set_right_status(window)
  local ARROW = utf8.char(0xe0b2)

  local segments = {
    window:active_workspace(),
    wezterm.strftime('%a %b %-d %H:%M')
  }

  local foreground = "#fff"
  local backgrounds = {
    "#d79921",
    "#d65d0e"
  }

  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = "none" } })
    end

    table.insert(elements, { Foreground = { Color = backgrounds[i] } })
    table.insert(elements, { Text = ARROW })

    table.insert(elements, { Foreground = { Color = foreground } })
    table.insert(elements, { Background = { Color = backgrounds[i] } })
    table.insert(elements, { Text = " " .. seg .. " " })
  end

  window:set_right_status(wezterm.format(elements))
end

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
    set_left_status(window)
    set_right_status(window)
  end)
end

return module
