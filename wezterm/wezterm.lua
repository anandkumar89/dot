local wezterm = require 'wezterm'
-- local features = require 'theme_switcher'
local act = wezterm.action

local keys = {}
local tmuxlike = {
    -- splits
    { key = '-', mods = 'LEADER', action = act.SplitVertical { domain = 'CurrentPaneDomain' } },
    { key = '\\', mods = 'LEADER', action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },

    -- pane navigation
    { key = 'h', mods = 'LEADER', action = act.ActivatePaneDirection 'Left' },
    { key = 'j', mods = 'LEADER', action = act.ActivatePaneDirection 'Down' },
    { key = 'k', mods = 'LEADER', action = act.ActivatePaneDirection 'Up' },
    { key = 'l', mods = 'LEADER', action = act.ActivatePaneDirection 'Right' },

    -- zoom pane
    { key = 'z', mods = 'LEADER', action = act.TogglePaneZoomState },

    -- new window (WezTerm tab)
	{ key = 'n', mods = 'LEADER', action = act.SpawnWindow },
    { key = 'c', mods = 'LEADER', action = act.SpawnTab 'CurrentPaneDomain' },
    { key = 'x', mods = 'LEADER', action = act.CloseCurrentPane { confirm = true } },
    { key = 'q', mods = 'LEADER', action = act.PaneSelect { mode = 'Activate' } },
  }

local ctrl_cmd_swap = { "a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z", "[", "]", "\\"}

for _, k in ipairs(ctrl_cmd_swap) do
	table.insert(keys, {key=k, mods="CMD", action=wezterm.action.SendKey{key=k, mods="CTRL"}})
	table.insert(keys, {key=k, mods="CTRL", action=wezterm.action.SendKey{key=k, mods="CMD"}})
end

for _, k in ipairs(tmuxlike) do
	table.insert(keys, k)
end

local dark_theme = 'Builtin Dark' 
local light_theme = 'Builtin Light'
function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return 'Dark'
end

function scheme_for_appearance(appearance)
	if appearance:find 'Dark' then
		return dark_theme
	else
		return light_theme
	end
end

config = {
	window_decorations = "NONE",
	font_size = 14.0,
	-- set first index to 1 
	window_padding = { left = 0, right = 0, top = 0, bottom = 0 },
	window_decorations = "RESIZE",
	-- window_background_opacity = 0.9,
	text_background_opacity = 1.0,
	use_fancy_tab_bar = false,
	inactive_pane_hsb = { saturation = 1, brightness = 0.9},
	color_scheme = scheme_for_appearance(get_appearance()),
	enable_tab_bar = false,
	-- tab_bar_at_bottom = true,
	-- hide_tab_bar_if_only_one_tab = true,
	-- send_composed_key_when_left_alt_is_pressed = false,
	send_composed_key_when_right_alt_is_pressed = false,
	font = wezterm.font_with_fallback {
	{ family = "JetBrainsMono Nerd Font", weight = "Regular" },
	{ family = "JetBrainsMono Nerd Font", weight = "Bold" },
	"Symbols Nerd Font",
	},
	audible_bell = "Disabled",
	disable_default_key_bindings = true,
	adjust_window_size_when_changing_font_size = false,
	leader = { key = 'b', mods = 'CMD', timeout_milliseconds = 1000 },
	keys = keys,
}

wezterm.on("switch_theme", function (window, pane)
	local overrides = window:get_config_overrides() or {}
	-- log info
	local csc = overrides.color_scheme or config.color_scheme
	wezterm.log_info("Current color scheme: " .. tostring(csc))
	if csc:find 'Dark' then
		overrides.color_scheme = 'Builtin Light'
	else
		overrides.color_scheme = 'Builtin Dark'
	end
	window:set_config_overrides(overrides)
end)

table.insert(config.keys, { key = "O", mods = "CMD|SHIFT", action = wezterm.action.EmitEvent("switch_theme") })

-- table.insert(config.keys, { key = "=", mods = "CMD", action = wezterm.action.ShowDebugOverlay })

-- Handy tmux-style tab/split bindings
table.insert(config.keys, { key = "t", mods = "CMD|SHIFT", action = wezterm.action.SpawnTab "CurrentPaneDomain" })
table.insert(config.keys, { key = "w", mods = "CMD|SHIFT", action = wezterm.action.CloseCurrentTab { confirm = true } })
table.insert(config.keys, { key = "Enter", mods = "CMD|SHIFT", action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" } })
table.insert(config.keys, { key = "-", mods = "CMD|SHIFT", action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" } })
table.insert(config.keys, { key = "H", mods = "CMD", action = wezterm.action.ActivatePaneDirection "Left" })
table.insert(config.keys, { key = "J", mods = "CMD", action = wezterm.action.ActivatePaneDirection "Down" })
table.insert(config.keys, { key = "K", mods = "CMD", action = wezterm.action.ActivatePaneDirection "Up" })
table.insert(config.keys, { key = "L", mods = "CMD", action = wezterm.action.ActivatePaneDirection "Right" })
table.insert(config.keys, { key = "Z", mods = "CMD", action = wezterm.action.TogglePaneZoomState })


-- paste 
table.insert(config.keys, { key = "v", mods = "CMD|SHIFT", action = wezterm.action.PasteFrom "Clipboard" })
table.insert(config.keys, { key = 'p', mods = 'CMD|SHIFT', action = wezterm.action.ActivateCommandPalette })
for i = 1, 9 do
  table.insert(config.keys, { key = tostring(i), mods = 'CMD', action = wezterm.action.ActivateTab(i-1)})
  table.insert(config.keys, { key = tostring(i), mods = 'CMD|SHIFT', action = wezterm.action.ActivateWindow(9-i)})
end

-- rotate pane clockwise 
table.insert(config.keys, { key = "}", mods = "CMD|SHIFT", action = wezterm.action.RotatePanes "Clockwise" })
table.insert(config.keys, { key = "{", mods = "CMD|SHIFT", action = wezterm.action.RotatePanes "CounterClockwise" })
-- prefix + w for window list
table.insert(config.keys, { key = "w", mods = "LEADER", action = wezterm.action.ShowTabNavigator })

-- copy mode
table.insert(config.keys, { key = "C", mods = "CMD|SHIFT", action = wezterm.action.ActivateCopyMode })
table.insert(config.keys, { key = "]", mods = "CMD", action = wezterm.action.ClearSelection })	

-- search mode 
table.insert(config.keys, { key = "f", mods = "CMD|SHIFT", action = wezterm.action.Search { CaseInSensitiveString = "" } })

config.ssh_domains = {
  {
    -- This name should match the host you're connecting to
    name = '10.119.2.11', 
    remote_address = '10.119.2.11',
    multiplexing = "WezTerm",
    -- Tell wezterm the exact path to the binary on the remote server
    -- (Replace 'your_username' with your actual remote username)
    remote_wezterm_path = '/home/anand.kumar/bin/wezterm',
  },
}

return config
