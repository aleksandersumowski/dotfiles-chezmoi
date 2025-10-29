local wezterm = require("wezterm")
local extrakto = require("extrakto")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = "nord"
-- config.window_decorations = "NONE" -- conflicts with rectangle
-- config.font = wezterm.font("JetBrains Mono")
config.font = wezterm.font("NotoSansM Nerd Font Mono")
config.font_size = 13.0
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 100001
config.keys = {
	{ key = "a", mods = "LEADER|CTRL", action = wezterm.action.SendKey({ key = "a", mods = "CTRL" }) },
	{ key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "s", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{
		key = "\\",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ key = "&", mods = "LEADER|SHIFT", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	{ key = "0", mods = "LEADER", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },
	{ key = "1", mods = "LEADER", action = wezterm.action({ ActivateTab = 0 }) },
	{ key = "2", mods = "LEADER", action = wezterm.action({ ActivateTab = 1 }) },
	{ key = "3", mods = "LEADER", action = wezterm.action({ ActivateTab = 2 }) },
	{ key = "4", mods = "LEADER", action = wezterm.action({ ActivateTab = 3 }) },
	{ key = "5", mods = "LEADER", action = wezterm.action({ ActivateTab = 4 }) },
	{ key = "6", mods = "LEADER", action = wezterm.action({ ActivateTab = 5 }) },
	{ key = "7", mods = "LEADER", action = wezterm.action({ ActivateTab = 6 }) },
	{ key = "8", mods = "LEADER", action = wezterm.action({ ActivateTab = 7 }) },
	{ key = "9", mods = "LEADER", action = wezterm.action({ ActivateTab = 8 }) },
	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "J", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "K", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Up", 6 } }) },
	{ key = "L", mods = "LEADER|SHIFT", action = wezterm.action({ AdjustPaneSize = { "Right", 7 } }) },
	{ key = "a", mods = "LEADER", action = wezterm.action.PaneSelect({ show_pane_ids = true }) },
	{ key = "b", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
	{ key = "c", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "o", mods = "LEADER", action = "TogglePaneZoomState" },
	{ key = "q", mods = "LEADER", action = wezterm.action.QuickSelect },
	{ key = "r", mods = "LEADER", action = wezterm.action.ReloadConfiguration },
	{ key = "s", mods = "LEADER", action = wezterm.action.PaneSelect({ mode = "SwapWithActive" }) },
	{ key = "t", mods = "LEADER", action = wezterm.action.PaneSelect({ mode = "MoveToNewTab" }) },
	{ key = "x", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action.ShowLauncherArgs({
			flags = "FUZZY|TABS|LAUNCH_MENU_ITEMS|KEY_ASSIGNMENTS|COMMANDS",
		}),
	},
}

-- Add extrakto key bindings
local extrakto_keys = extrakto.get_keys()
for _, key in ipairs(extrakto_keys) do
	table.insert(config.keys, key)
end

-- Show when leader key is active
wezterm.on("update-right-status", function(window, pane)
	local leader = ""
	if window:leader_is_active() then
		leader = "LEADER"
	end
	window:set_right_status(leader)
end)

return config
