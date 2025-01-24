local module = {}

module.setup = function(config)
  config.initial_rows = 35
  config.initial_cols = 150

  config.exit_behavior = "Close"
  config.exit_behavior_messaging = "None"
  config.window_close_confirmation = "NeverPrompt"
end

return module
