local wezterm = require("wezterm")

local module = {}

module.setup = function(config)
  local platform = wezterm.target_triple

  local launch_menu = {}

  if (platform:find("windows")) then
    config.default_prog = { "pwsh.exe", "-NoLogo" }

    table.insert(launch_menu, {
      label = "PowerShell",
      args = { "pwsh.exe", "-NoLogo" }
    })

    table.insert(launch_menu, {
      label = "PowerShell (legacy)",
      args = { "powershell.exe", "-NoLogo" }
    })

    table.insert(launch_menu, {
      label = "Command Prompt",
      args = { "cmd.exe" }
    })
  else
    config.default_prog = { "/usr/local/bin/zsh", "-NoLogo" }

    table.insert(launch_menu, {
      label = "zsh",
      args = { "/usr/local/bin/bash" }
    })

    table.insert(launch_menu, {
      label = "bash",
      args = { "/usr/local/bin/bash" }
    })

    table.insert(launch_menu, {
      label = "PowerShell",
      args = { "/usr/local/bin/pswh", "-NoLogo" }
    })
  end

  config.launch_menu = launch_menu
end

return module
