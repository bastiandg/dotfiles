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

local function current_cmd(pane)
	local info = pane:get_foreground_process_info() or {}
	local argv = info.argv or {}
	for _, arg in ipairs(argv) do
		local cmd = arg:match("([^/\\]+)$") -- strip path
		if cmd == "gemini" or cmd == "claude" then
			return cmd
		end
	end
	return nil
end

config.keys = {
	{ key = "LeftArrow", mods = "SHIFT", action = act.ActivateTabRelative(-1) },
	{ key = "RightArrow", mods = "SHIFT", action = act.ActivateTabRelative(1) },
	{ key = "RightArrow", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
	{ key = "LeftArrow", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
	{ key = "n", mods = "CTRL|SHIFT", action = act({ SpawnCommandInNewTab = { cwd = wezterm.home_dir } }) },
	{ key = "UpArrow", mods = "SHIFT", action = act.ScrollByLine(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = act.ScrollByLine(1) },
	{
		key = "Enter",
		mods = "SHIFT",
		action = wezterm.action_callback(function(window, pane)
			local cmd = current_cmd(pane)
			if cmd == "claude" or cmd == "gemini" then
				window:perform_action(act.SendString("\n"), pane)
			else
				window:perform_action(act.SendKey({ key = "Enter" }), pane)
			end
		end),
	},
}

return config
