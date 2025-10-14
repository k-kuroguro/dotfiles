local wezterm = require("wezterm")
local utils = require("utils")
local config = wezterm.config_builder()

config.color_scheme = "Vs Code Dark+ (Gogh)"

config.font = wezterm.font("HackGen Console NF")
config.font_size = 11.5

config.animation_fps = 1

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

local local_config = utils.load_config(wezterm.home_dir .. "/.config/wezterm/local.lua")
utils.merge_tables_inplace(config, local_config)

return config
