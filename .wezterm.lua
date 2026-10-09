local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- config.default_domain = "WSL:Ubuntu"
config.color_scheme = "Tokyo Night"
config.font = wezterm.font("CaskaydiaCove Nerd Font")
config.font_size = 15.0
-- Only the background is transparent; text keeps full opacity (text_background_opacity defaults to 1.0).
config.window_background_opacity = 0.85
config.macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "TITLE | RESIZE"

-- Dim unfocused windows so the focused one is obvious at a glance.
local UNFOCUSED_FOREGROUND_TEXT_HSB = { hue = 1.0, saturation = 0.25, brightness = 0.45 }
local UNFOCUSED_WINDOW_BACKGROUND_OPACITY = 0.62

-- get_config_overrides() hands back a copy, so the current value is never the
-- same table we last stored; compare the fields instead of the identity.
local function same_text_hsb(actual, expected)
	if actual == nil or expected == nil then
		return actual == expected
	end
	return actual.hue == expected.hue
		and actual.saturation == expected.saturation
		and actual.brightness == expected.brightness
end

-- wezterm.GLOBAL survives the config reloads that set_config_overrides() triggers.
local function apply_window_appearance(window)
	local overrides = window:get_config_overrides() or {}
	local text_hsb, opacity
	if wezterm.GLOBAL.opaque_background then
		opacity = 1.0
	end
	if not window:is_focused() then
		text_hsb = UNFOCUSED_FOREGROUND_TEXT_HSB
		opacity = UNFOCUSED_WINDOW_BACKGROUND_OPACITY
	end

	-- Only write when one of the two values we own actually changes; a redundant
	-- set_config_overrides() call would trigger another config reload.
	if same_text_hsb(overrides.foreground_text_hsb, text_hsb) and overrides.window_background_opacity == opacity then
		return
	end

	overrides.foreground_text_hsb = text_hsb
	overrides.window_background_opacity = opacity
	window:set_config_overrides(overrides)
end

wezterm.on("window-focus-changed", apply_window_appearance)

wezterm.on("toggle-background-opacity", function(window)
	wezterm.GLOBAL.opaque_background = not wezterm.GLOBAL.opaque_background
	apply_window_appearance(window)
end)

-- Define user event to toggle window decorations
wezterm.on('toggle-decorations', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  if overrides.window_decorations == 'RESIZE' then
    overrides.window_decorations = 'TITLE | RESIZE'
  else
    overrides.window_decorations = 'RESIZE'
  end
  window:set_config_overrides(overrides)
end)

-- Bind the action to a key (e.g., CTRL+SHIFT+D)
config.keys = {
  {
    key = 'd',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.EmitEvent('toggle-decorations'),
  },
  {
    key = 'b',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.EmitEvent('toggle-background-opacity'),
  },
}


return config
