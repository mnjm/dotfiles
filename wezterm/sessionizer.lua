-- OS Independent sessionizer
-- see https://github.com/wez/wezterm/discussions/4796
local wezterm = require("wezterm")
local act = wezterm.action
local M = {}
local fd = nil
local projects_dir = nil
local dir_icon = "  "
local workspace_icon = "  "

local target = wezterm.target_triple:lower()
if target:find("linux") then
  fd = "/usr/bin/fd"
  projects_dir = os.getenv("HOME") .. "/workspace"
elseif target:find("darwin") then
  fd = "/opt/homebrew/bin/fd"
  projects_dir = os.getenv("HOME") .. "/workspace"
elseif target:find("windows") then
  -- Install fd using `winget install sharkdp.fd`
  fd = "fd"
  projects_dir = "C:\\workspace"
else
  wezterm.log_info("Unknown OS: " .. target)
end

local function get_entries()
  local ws_f_d = {}
  local entries = {}

  local existing_workspaces = wezterm.mux.get_workspace_names()
  for _, ws in ipairs(existing_workspaces) do
    ws_f_d[ws] = true
    if ws ~= wezterm.mux.get_active_workspace() then
      table.insert(entries, { label = workspace_icon .. tostring(ws), id = nil })
    end
  end

  local success, stdout, stderr
  if fd and projects_dir then
    local cmd
    cmd = { fd, "-t", "d", "--max-depth=1", ".", projects_dir }
    success, stdout, stderr = wezterm.run_child_process(cmd)
  end

  if not success then
    wezterm.log_error("Failed to list projects: " .. (stderr or "<no stderr>"))
    return entries
  end

  for path in stdout:gmatch("([^\r\n]+)") do
    path = path:gsub("[/\\]$", "")
    local basename = path:match("([^/\\]+)$")
    if basename and ws_f_d[basename] == nil then
      table.insert(entries, { label = dir_icon .. basename, id = path })
    end
  end

  return entries
end

local function set_last_workspace(win)
  wezterm.log_info("Setting last workspace to " .. win:active_workspace())
  wezterm.GLOBAL.sessionizer_last_workspace = win:active_workspace()
end

local function get_last_workspace()
  local last_workspace = wezterm.GLOBAL.sessionizer_last_workspace
  wezterm.log_info("Got last workspace as " .. tostring(last_workspace))
  return last_workspace
end

M.show = function(win, pane)
  local entries = get_entries()
  if #entries == 0 then
    wezterm.log_info("No projects in " .. tostring(projects_dir))
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
