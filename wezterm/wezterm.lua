local wezterm = require "wezterm"
local sessionizer = require("sessionizer")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = 'Adventure'
config.window_background_opacity = 0.87
config.font = wezterm.font("UbuntuMono Nerd Font")
config.font_size = 14

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
    {
        mods = "LEADER",
        key = "t",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
    {
        mods = "LEADER",
        key = "w",
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    {
        mods = "LEADER",
        key = "<",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        mods = "LEADER",
        key = ">",
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        mods = "LEADER",
        key = "\\",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "-",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "LeftArrow",
        action = wezterm.action.ActivatePaneDirection "Left"
    },
    {
        mods = "LEADER",
        key = "DownArrow",
        action = wezterm.action.ActivatePaneDirection "Down"
    },
    {
        mods = "LEADER",
        key = "UpArrow",
        action = wezterm.action.ActivatePaneDirection "Up"
    },
    {
        mods = "LEADER",
        key = "RightArrow",
        action = wezterm.action.ActivatePaneDirection "Right"
    },
    {
        mods = "LEADER",
        key = "h",
        action = wezterm.action.AdjustPaneSize { "Left", 5 }
    },
    {
        mods = "LEADER",
        key = "l",
        action = wezterm.action.AdjustPaneSize { "Right", 5 }
    },
    {
        mods = "LEADER",
        key = "j",
        action = wezterm.action.AdjustPaneSize { "Down", 5 }
    },
    {
        mods = "LEADER",
        key = "k",
        action = wezterm.action.AdjustPaneSize { "Up", 5 }
    },
    {
        mods = "LEADER",
        key = "s",
        action = wezterm.action_callback(sessionizer.show),
    },
    {
        mods = "LEADER",
        key = "S",
        action = wezterm.action_callback(sessionizer.create_new),
    },
    {
        key = 'L',
        mods = 'LEADER',
        action = wezterm.action.ShowDebugOverlay
    },
}

for i = 0, 9 do
    -- leader + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action.ActivateTab(i),
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

    workspace = " " .. window:active_workspace() .. " "
    window:set_right_status(wezterm.format {
        { Background = { AnsiColor = "Black" } },
        { Attribute = { Intensity = "Half" }},
        { Text = workspace },
    })
end)

return config
