local wezterm = require("wezterm")
local config = wezterm.config_builder()
-- config.font = wezterm.font("Agave Nerd Font")
-- config.font = wezterm.font("0xProto Nerd Font")
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Light", stretch = "Normal", style = "Normal" })
config.font_size = 16.0
config.enable_tab_bar = true

config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.75
config.macos_window_background_blur = 8

--config.color_scheme = "Batman"

return config
