local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 20
config.font = wezterm.font("SauceCodePro Nerd Font", { weight = "Medium" })

config.color_scheme = "Argonaut"

config.colors = {
	foreground = "White",
	background = "Black",
	cursor_bg = "White",
	cursor_fg = "Black",
	cursor_border = "White",
}

config.cursor_blink_rate = 0
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

local act = wezterm.action

config.keys = {
	{ key = "LeftArrow", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "n", mods = "CTRL|SHIFT", action = act({ SpawnCommandInNewTab = { cwd = wezterm.home_dir } }) },
	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },
}

return config
