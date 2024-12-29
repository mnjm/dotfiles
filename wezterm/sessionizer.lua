-- see https://github.com/wez/wezterm/discussions/4796
local wezterm = require("wezterm")
local act = wezterm.action

local M = {}

local fd = "/opt/homebrew/bin/fd"
local workspace = os.getenv("HOME") .. "/workspace"

M.toggle = function(window, pane)
    local projects = {}

    local success, stdout, stderr = wezterm.run_child_process({
        fd,
        "-HI",
        "^.git$",
        "--max-depth=4",
        "--prune",
        workspace
    })

    if not success then
        wezterm.log_error("Failed to run fd: " .. stderr)
        return
    end

    for line in stdout:gmatch("([^\n]*)\n?") do
        local project = line:gsub("/.git.*$", "")
        local label = project
        local id = project:gsub(".*/", "")
        table.insert(projects, { label = tostring(label), id = tostring(id) })
    end

    window:perform_action(
    act.InputSelector({
        action = wezterm.action_callback(function(win, _, id, label)
            if not id and not label then
                wezterm.log_info("Cancelled")
            else
                wezterm.log_info("Selected " .. label)
                win:perform_action(
                act.SwitchToWorkspace({ name = id, spawn = { cwd = label } }),
                pane
                )
            end
        end),
        fuzzy = true,
        title = "Select project",
        choices = projects,
    }),
    pane
    )
end

return M
