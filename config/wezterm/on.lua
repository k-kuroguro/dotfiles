local wezterm = require("wezterm")

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	return "WezTerm"
end)
