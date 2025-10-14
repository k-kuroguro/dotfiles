local wezterm = require("wezterm")
local utils = require("utils")

require("on")

local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = "Vs Code Dark+ (Gogh)"

config.font = wezterm.font("HackGen Console NF")
config.font_size = 11

config.animation_fps = 1

config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.window_padding = {
   left = "0.75cell",
   right = "0.75cell",
   top = 0,
   bottom = 0,
}

config.enable_tab_bar = false

config.disable_default_key_bindings = true
config.keys = {
   { key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
   { key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
   { key = "Insert", mods = "CTRL", action = act.CopyTo("PrimarySelection") },
   { key = "Insert", mods = "SHIFT", action = act.PasteFrom("PrimarySelection") },
   { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
   { key = "PageUp", mods = "SHIFT", action = act.ScrollByPage(-1) },
   { key = "PageDown", mods = "SHIFT", action = act.ScrollByPage(1) },
   { key = "phys:Space", mods = "SHIFT|CTRL", action = act.QuickSelect },
   { key = "l", mods = "SHIFT|CTRL", action = act.ShowDebugOverlay },
}

local local_config = utils.load_config(wezterm.home_dir .. "/.config/wezterm/local.lua")
utils.merge_tables_inplace(config, local_config)

return config
