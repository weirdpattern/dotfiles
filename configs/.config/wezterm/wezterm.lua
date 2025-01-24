local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("config.theme").setup(config)
require("config.options").setup(config)

require("config.shell").setup(config)
require("config.panes").setup(config)

require("config.links").setup(config)
require("config.mouse").setup(config)
require("config.keybindings").setup(config)

local at_work,work = pcall(require,"local.work")
if at_work then
  work.setup(config)
end

return config
