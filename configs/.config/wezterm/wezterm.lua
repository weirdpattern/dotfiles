local wezterm = require("wezterm")
local config = wezterm.config_builder()

require("segments.theme").setup(config)
require("segments.options").setup(config)

require("segments.shell").setup(config)
require("segments.panes").setup(config)

require("segments.links").setup(config)
require("segments.mouse").setup(config)
require("segments.keybindings").setup(config)

local at_work,work = pcall(require,"local.work")
if at_work then
  work.setup(config)
end

return config
