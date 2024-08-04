local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- wezterm ls-fonts --list-system
-- config.font = wezterm.font("Agave Nerd Font")
--config.font = wezterm.font("0xProto Nerd Font")
config.font = wezterm.font("JetBrainsMono Nerd Font")
--config.font = wezterm.font("RecMonoCasual Nerd Font")
--config.font = wezterm.font("RecMonoDuotone Nerd Font")
-- config.font = wezterm.font("RecMonoLinear Nerd Font")
config.font_size = 15.0
config.enable_tab_bar = true

config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.75
config.macos_window_background_blur = 8

config.color_scheme = "Catppuccin Mocha"

return config
