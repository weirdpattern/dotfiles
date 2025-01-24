local wezterm = require("wezterm")
local action = wezterm.action

local at_work,work = pcall(require, "local.work")
local at_personal,personal = pcall(require, "local.personal")

local module = {}

local function get_project_dirs()
  local projects = {}

  if at_personal then
    local personal_projects = personal.get_project_dirs()
    for i = 1, #personal_projects do
      personal_projects[i].label = "Personal: " .. personal_projects[i].label
      table.insert(projects, personal_projects[i])
    end
  end

  if at_work then
    local work_projects = work.get_project_dirs()
    for i = 1, #work_projects do
      work_projects[i].label = "Work: " .. work_projects[i].label
      table.insert(projects, work_projects[i])
    end
  end

  return projects
end

module.select_project = function()
  local choices = {}
  for _, value in ipairs(get_project_dirs()) do
    table.insert(choices, value)
  end

  return action.InputSelector {
    title = "Workspaces",
    choices = choices,
    fuzzy = true,
    action = wezterm.action_callback(function(window, pane, id, label)
      if not id and not label then return end

      window:perform_action(action.SwitchToWorkspace {
        name = label,
        spawn = { cwd = id }
      }, pane)
    end)
  }
end

return module
