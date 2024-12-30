-- see https://github.com/wez/wezterm/discussions/4796
local wezterm = require("wezterm")
local act = wezterm.action
local M = {}
local fd = "/opt/homebrew/bin/fd"
local workspace = os.getenv("HOME") .. "/workspace"

local function get_entries()
    local ws_f_d = {}
    local entries = {}
    -- get existing workspaces
    local existing_workspaces = wezterm.mux.get_workspace_names()
    for _, ws in ipairs(existing_workspaces) do
        ws_f_d[ws] = true
        -- ignore if current active workspace but dont add folder entry too
        if ws ~= wezterm.mux.get_active_workspace() then
            table.insert(entries, { label = tostring(ws), id = nil })
        end
    end
    -- get projects from workspace dir
    local success, stdout, stderr = wezterm.run_child_process({
        fd,
        "-t", "d",
        "--max-depth=1",
        ".",
        workspace
    })
    if not success then
        wezterm.log_error("Failed to run fd: " .. stderr)
        return entries
    end
    for path in stdout:gmatch("([^\n]*)\n?") do
        path = path:gsub("/$", "")  -- Remove trailing slash if present
        local basename = path:match("[^/]+$") -- Extract basename
        if ws_f_d[basename] == nil then
            table.insert(entries, { label = basename, id = path })
        end
    end
    return entries
end

M.show = function(window, pane)
    -- get entries
    local entries = get_entries()
    if #entries == 0 then
        wezterm.log_info("No projects in " .. workspace)
        return
    end

    window:perform_action(
        -- fuzzy search
        act.InputSelector({
            action = wezterm.action_callback(function(win, _, path, workspace)
               if workspace then
                   -- if path then create a spawn command
                   local spawn_cmd = nil
                   if path then
                       spawn_cmd = { cwd = path }
                   end
                   win:perform_action(
                       act.SwitchToWorkspace({
                           name = workspace,
                           spawn = spawn_cmd,
                       }),
                       pane
                   )
               end
           end),
            fuzzy = true,
            title = "Select workspace",
            fuzzy_description = "Fuzzy matching workspace:",
            choices = entries,
        }),
        pane
    )
end

return M
