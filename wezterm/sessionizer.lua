-- see https://github.com/wez/wezterm/discussions/4796
local wezterm = require("wezterm")
local act = wezterm.action
local M = {}
local fd = "/opt/homebrew/bin/fd"
local projects_dir = os.getenv("HOME") .. "/workspace"
local dir_icon = "  "
local workspace_icon = "  "

local function get_entries()
    local ws_f_d = {}
    local entries = {}
    -- get existing workspaces
    local existing_workspaces = wezterm.mux.get_workspace_names()
    for _, ws in ipairs(existing_workspaces) do
        ws_f_d[ws] = true
        -- ignore if current active workspace but dont add folder entry too
        if ws ~= wezterm.mux.get_active_workspace() then
            table.insert(entries, { label = workspace_icon .. tostring(ws), id = nil })
        end
    end
    -- get projects from workspace dir
    local success, stdout, stderr = wezterm.run_child_process({
        fd,
        "-t", "d",
        "--max-depth=1",
        ".",
        projects_dir
    })
    if not success then
        wezterm.log_error("Failed to run fd: " .. stderr)
        return entries
    end
    for path in stdout:gmatch("([^\n]*)\n?") do
        path = path:gsub("/$", "")  -- Remove trailing slash if present
        local basename = path:match("[^/]+$") -- Extract basename
        if ws_f_d[basename] == nil then
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
    wezterm.log_info("Got last workspace as "  .. last_workspace)
    return last_workspace
end

M.show = function(win, pane)
    -- get entries
    local entries = get_entries()
    if #entries == 0 then
        wezterm.log_info("No projects in " .. workspace)
        return
    end

    win:perform_action(
    -- fuzzy search
    act.InputSelector({
        action = wezterm.action_callback(function(win, _, path, workspace)
            if workspace then
                -- if path then create a spawn command
                local spawn_cmd = nil
                if path then
                    spawn_cmd = { cwd = path }
                end
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
        fuzzy_description = wezterm.format {
            { Attribute = { Intensity = 'Bold' } },
            { Foreground = { AnsiColor = 'Green' } },
            { Text = 'Fuzzy matching workspace:' },
        },
        choices = entries,
    }),
    pane
    )
end

M.create_new = function(win, pane)
    win:perform_action(
    act.PromptInputLine {
        description = wezterm.format {
            { Attribute = { Intensity = 'Bold' } },
            { Foreground = { AnsiColor = 'Green' } },
            { Text = 'Enter name for new workspace' },
        },
        action = wezterm.action_callback(function(win, pane, line)
            if line then
                set_last_workspace(win)
                win:perform_action(
                act.SwitchToWorkspace {
                    name = line,
                },
                pane
                )
            end
        end),
    },
    pane
    )
end

M.switch_to_last = function(win, pane)
    local last_workspace = get_last_workspace()
    if last_workspace and last_workspace ~= win:active_workspace() then
        set_last_workspace(win)
        win:perform_action(
        act.SwitchToWorkspace {
            name = last_workspace
        }, pane 
        )
    end
end

return M
