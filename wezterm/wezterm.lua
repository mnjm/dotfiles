local wezterm = require "wezterm"
local options = ({ ... })[1]
options = type(options) == "table" and options or {}
local sessionizer_enabled = options.sessionizer ~= false
local server = options.server == true
local sessionizer = sessionizer_enabled and require("sessionizer") or nil

-- maximize window on startup (not fullscreen)
wezterm.on("gui-startup", function(cmd)
  local _, _, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'Colors (base16)'
config.window_background_opacity = 0.87
config.font = wezterm.font("UbuntuMono Nerd Font")
config.font_size = 13

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
    { mods = "LEADER", key = "t", action = wezterm.action.SpawnTab "CurrentPaneDomain", },
    { mods = "LEADER", key = "w", action = wezterm.action.CloseCurrentPane { confirm = true } },
    { mods = "LEADER", key = "<", action = wezterm.action.ActivateTabRelative(-1) },
    { mods = "LEADER", key = ">", action = wezterm.action.ActivateTabRelative(1) },
    { mods = "LEADER", key = "\\", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } },
    { mods = "LEADER", key = "-", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } },
    { mods = "LEADER", key = "LeftArrow", action = wezterm.action.ActivatePaneDirection "Left" },
    { mods = "LEADER", key = "DownArrow", action = wezterm.action.ActivatePaneDirection "Down" },
    { mods = "LEADER", key = "UpArrow", action = wezterm.action.ActivatePaneDirection "Up" },
    { mods = "LEADER", key = "RightArrow", action = wezterm.action.ActivatePaneDirection "Right" },
    { mods = "LEADER", key = "h", action = wezterm.action.AdjustPaneSize { "Left", 5 } },
    { mods = "LEADER", key = "l", action = wezterm.action.AdjustPaneSize { "Right", 5 } },
    { mods = "LEADER", key = "j", action = wezterm.action.AdjustPaneSize { "Down", 5 } },
    { mods = "LEADER", key = "k", action = wezterm.action.AdjustPaneSize { "Up", 5 } },
    { mods = 'LEADER', key = "L", action = wezterm.action.ShowDebugOverlay },
}

if sessionizer_enabled then
    table.insert(config.keys, { mods = "LEADER", key = "s", action = wezterm.action_callback(sessionizer.show) })
    table.insert(config.keys, { mods = "LEADER", key = "S", action = wezterm.action_callback(sessionizer.create_new) })
    table.insert(config.keys, { mods = "LEADER", key = "R", action = wezterm.action_callback(sessionizer.rename_workspace) })
    table.insert(config.keys, { mods = "LEADER", key = "p", action = wezterm.action_callback(sessionizer.switch_to_last) })
end

if server then
    config.default_workspace = "server"
end

for i = 1, 9 do
    -- leader + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i-1),
    })
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

-- tmux status
wezterm.on("update-right-status", function(window, _)
    local prefix = ""

    if window:leader_is_active() then
        prefix = " " .. utf8.char(0x1F440) .. " "
    end

    window:set_left_status(wezterm.format {
        { Text = prefix },
    })

    local workspace = " " .. (server and "server" or window:active_workspace()) .. " "
    window:set_right_status(wezterm.format {
        { Background = { AnsiColor = server and "Red" or "Black" } },
        { Foreground = { AnsiColor = server and "Black" or "White" } },
        { Attribute = { Intensity = "Half" }},
        { Text = workspace },
    })
end)

return config
