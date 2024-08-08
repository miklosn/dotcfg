local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- wezterm ls-fonts --list-system
--
config.font = wezterm.font_with_fallback({
	"IBM Plex Mono",
	--"Syne Mono",
	"Symbols Nerd Font Mono",
})
--config.font = wezterm.font("Agave Nerd Font")
--config.font = wezterm.font("0xProto Nerd Font")
--config.font = wezterm.font("JetBrainsMono Nerd Font")
--config.font = wezterm.font("RecMonoCasual Nerd Font")
--config.font = wezterm.font("RecMonoDuotone Nerd Font")
-- config.font = wezterm.font("RecMonoLinear Nerd Font")
-- config.font = wezterm.font("Inconsolata Nerd Font")

config.font_size = 16.0
config.enable_tab_bar = true

config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.75
config.macos_window_background_blur = 0

--config.color_scheme = "Catppuccin Mocha"
config.color_scheme = "Eldritch"
config.text_background_opacity = 0.8

config.window_background_image = "/Users/mico/wp.jpg"
config.window_background_image_hsb = {
	-- Darken the background image by reducing it to 1/3rd
	brightness = 0.1,

	-- You can adjust the hue by scaling its value.
	-- a multiplier of 1.0 leaves the value unchanged.
	hue = 1,

	-- You can adjust the saturation also.
	saturation = 0.8,
}

config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font({ family = "Roboto", weight = "Bold" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 14.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#333333",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#333333",
}

config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#575757",
	},
}

config.keys = {
	{
		key = "+",
		mods = "CTRL|ALT|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "CTRL|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

return config
