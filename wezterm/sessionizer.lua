-- OS Independent sessionizer
-- see https://github.com/wez/wezterm/discussions/4796
local wezterm = require("wezterm")
local act = wezterm.action
local M = {}
local dir_icon = "  "
local workspace_icon = "  "

local target = wezterm.target_triple:lower()
local project_dirs
if target:find("linux") or target:find("darwin") then
  project_dirs = {
    { path = os.getenv("HOME") .. "/work", name = "work" },
    { path = os.getenv("HOME") .. "/personal", name = "personal" },
  }
elseif target:find("windows") then
  project_dirs = {
    { path = "C:\\work", name = "work" },
    { path = "C:\\personal", name = "personal" },
  }
else
  wezterm.log_info("Unknown OS: " .. target)
end

local function get_entries()
  local workspaces = {}
  local entries = {}

  local active_workspace = wezterm.mux.get_active_workspace()
  for _, ws in ipairs(wezterm.mux.get_workspace_names()) do
    workspaces[ws] = true
    if ws ~= active_workspace then
      table.insert(entries, { label = workspace_icon .. tostring(ws), id = nil })
    end
  end

  if project_dirs then
    for _, project_dir in ipairs(project_dirs) do
      local success, paths = pcall(wezterm.read_dir, project_dir.path)
      if not success then
        wezterm.log_error("Failed to list projects in " .. project_dir.path .. ": " .. tostring(paths))
      else
        for _, path in ipairs(paths) do
          local basename = path:match("([^/\\]+)$")
          local workspace = basename and project_dir.name .. "/" .. basename
          local is_directory = pcall(wezterm.read_dir, path)
          if is_directory and workspace and not workspaces[workspace] then
            table.insert(entries, { label = dir_icon .. workspace, id = path })
          end
        end
      end
    end
  end

  return entries
end

local function set_last_workspace(win)
  local workspace = win:active_workspace()
  wezterm.log_info("Setting last workspace to " .. workspace)
  wezterm.GLOBAL.sessionizer_last_workspace = workspace
end

local function get_last_workspace()
  local last_workspace = wezterm.GLOBAL.sessionizer_last_workspace
  wezterm.log_info("Got last workspace as " .. tostring(last_workspace))
  return last_workspace
end

M.show = function(win, pane)
  local entries = get_entries()
  if #entries == 0 then
    wezterm.log_info("No projects found")
    return
  end

  win:perform_action(
    act.InputSelector({
      action = wezterm.action_callback(function(win, _, path, workspace)
        if workspace then
          local spawn_cmd = path and { cwd = path } or nil
          set_last_workspace(win)
          win:perform_action(
            act.SwitchToWorkspace({
              name = workspace:gsub("^[^%s]+%s*", ""), -- remove icon
              spawn = spawn_cmd,
            }),
            pane
          )
        end
      end),
      fuzzy = true,
      title = "Select workspace",
      fuzzy_description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Green" } },
        { Text = "Fuzzy matching workspace:" },
      }),
      choices = entries,
    }),
    pane
  )
end

M.create_new = function(win, pane)
  win:perform_action(
    act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Green" } },
        { Text = "Enter name for new workspace" },
      }),
      action = wezterm.action_callback(function(win, pane, line)
        if line then
          set_last_workspace(win)
          win:perform_action(
            act.SwitchToWorkspace({ name = line }),
            pane
          )
        end
      end),
    }),
    pane
  )
end

M.rename_workspace = function(win, pane)
  local current_workspace = wezterm.mux.get_active_workspace()
  win:perform_action(
    act.PromptInputLine({
      description = wezterm.format({
        { Attribute = { Intensity = "Bold" } },
        { Foreground = { AnsiColor = "Green" } },
        { Text = "Enter new name for workspace" },
      }),
      action = wezterm.action_callback(function(win, pane, line)
        if line and line ~= "" then
          win:perform_action(
            act.SwitchToWorkspace({ name = line }),
            pane
          )
          wezterm.mux.rename_workspace(current_workspace, line)
        end
      end),
    }),
    pane
  )
end

M.switch_to_last = function(win, pane)
  local last_workspace = get_last_workspace()
  if last_workspace and last_workspace ~= win:active_workspace() then
    set_last_workspace(win)
    win:perform_action(
      act.SwitchToWorkspace({ name = last_workspace }),
      pane
    )
  end
end

return M
