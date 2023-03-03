local wezterm = require("wezterm")
local action = wezterm.action

wezterm.on("toggle-opacity", function(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 0.75
	else
		overrides.window_background_opacity = nil
	end
	window:set_config_overrides(overrides)
end)

return {
	-- Font --

	-- font = wezterm.font("FiraCode Nerd Font"),
	-- font = wezterm.font("Operator Mono Lig"),

	-- Hack
	-- font = wezterm.font("Hack"),
	-- font_size = 14.0,
	-- cell_width = 1.10,
	-- line_height = 1.15,

	-- MesloLGS
	font = wezterm.font("MesloLGS NF"),
	font_size = 14.0,
	cell_width = 1.10,
	line_height = 1.1,

	-- SF Mono
	-- font = wezterm.font("SFMono Nerd Font"),
	-- font_size = 14,
	-- cell_width = 1.05,
	-- line_height = 1.15,

	-- Window --
	initial_cols = 141,
	initial_rows = 120,
	window_background_opacity = 0.95,
	window_decorations = "RESIZE",
	window_padding = { left = 20, right = 12, top = 12, bottom = 0 },
	-- launch_menu = {
	-- 	position = { x = 0, y = 0 },
	-- },

	-- Tab bar --
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = true,
	tab_and_split_indices_are_zero_based = false,
	window_frame = {
		-- The font used in the tab bar.
		-- Roboto Bold is the default; this font is bundled with wezterm.
		-- Whatever font is selected here, it will have the main font setting appended to it to pick up any fallback fonts you may have used there.
		font = wezterm.font({ family = "SFMono Nerd Font", weight = "Bold" }),

		-- The size of the font in the tab bar.
		font_size = 14.0,

		-- The overall background color of the tab bar when the window is focused
		active_titlebar_bg = "#151921",
	},

	-- Pane --
	inactive_pane_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 0.50,
		-- brightness = 1.00,
	},

	-- Text --
	text_blink_rate = 0, -- disable blinking text (for lazygit)

	-- Cursor --
	cursor_blink_rate = 1000,
	cursor_thickness = 3,

	-- Color scheme --
	-- 自分の好きなテーマ探す https://wezfurlong.org/wezterm/colorschemes/index.html
	-- color_scheme = "Catppuccin Mocha",
	color_scheme = "OneDark (base16)",
	-- color_scheme = "neobones_dark",
	-- color_scheme = "neon-night (Gogh)",

	colors = {
		background = "#0C0C1C",

		cursor_bg = "#CDD6F4",
		cursor_fg = "#0C0C1C",

		-- Tab --
		tab_bar = {
			active_tab = {
				bg_color = "#293253",
				fg_color = "#e0e0e0",
			},
			inactive_tab = {
				bg_color = "#050911",
				fg_color = "#515356",
			},
			inactive_tab_hover = {
				bg_color = "#050911",
				fg_color = "#d0d0d0",
			},
			-- new_tab = {},
			-- new_tab_hover = {},
		},
	},

	-- Key bindings --
	send_composed_key_when_left_alt_is_pressed = false, -- use option key as meta
	send_composed_key_when_right_alt_is_pressed = false,
	leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 },
	disable_default_key_bindings = true,

	keys = {
		{ key = "c", mods = "CMD", action = action({ CopyTo = "Clipboard" }) },
		{ key = "v", mods = "CMD", action = action({ PasteFrom = "Clipboard" }) },
		{ key = "-", mods = "CMD", action = "DecreaseFontSize" },
		{ key = "+", mods = "CMD|SHIFT", action = "IncreaseFontSize" },
		{ key = "]", mods = "LEADER", action = "QuickSelect" },
		{ key = "w", mods = "CMD", action = action({ CloseCurrentPane = { confirm = true } }) },
		{ key = "W", mods = "CMD|SHIFT", action = action({ CloseCurrentTab = { confirm = true } }) },

		-- Tmux-like key bindings
		-- Send "CTRL-Q" to the terminal when pressing CTRL-Q, CTRL-Q
		{ key = "q", mods = "LEADER|CTRL", action = wezterm.action({ SendString = "\x01" }) },
		{ key = "-", mods = "LEADER", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{
			key = "|",
			mods = "LEADER",
			action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		},
		{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
		{ key = "[", mods = "LEADER", action = "ActivateCopyMode" },
		{ key = "c", mods = "LEADER", action = action({ SpawnTab = "CurrentPaneDomain" }) },
		{ key = "n", mods = "LEADER", action = action({ ActivateTabRelative = 1 }) },
		{ key = "p", mods = "LEADER", action = action({ ActivateTabRelative = -1 }) },
		{ key = "]", mods = "CMD", action = action({ ActivateTabRelative = 1 }) },
		{ key = "[", mods = "CMD", action = action({ ActivateTabRelative = -1 }) },
		{ key = "h", mods = "LEADER", action = action({ ActivatePaneDirection = "Left" }) },
		{ key = "j", mods = "LEADER", action = action({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "LEADER", action = action({ ActivatePaneDirection = "Up" }) },
		{ key = "l", mods = "LEADER", action = action({ ActivatePaneDirection = "Right" }) },
		{ key = "H", mods = "CTRL|SHIFT", action = action({ AdjustPaneSize = { "Left", 5 } }) },
		{ key = "J", mods = "CTRL|SHIFT", action = action({ AdjustPaneSize = { "Down", 5 } }) },
		{ key = "K", mods = "CTRL|SHIFT", action = action({ AdjustPaneSize = { "Up", 5 } }) },
		{ key = "L", mods = "CTRL|SHIFT", action = action({ AdjustPaneSize = { "Right", 5 } }) },
		{ key = "1", mods = "LEADER", action = action({ ActivateTab = 0 }) },
		{ key = "2", mods = "LEADER", action = action({ ActivateTab = 1 }) },
		{ key = "3", mods = "LEADER", action = action({ ActivateTab = 2 }) },
		{ key = "4", mods = "LEADER", action = action({ ActivateTab = 3 }) },
		{ key = "5", mods = "LEADER", action = action({ ActivateTab = 4 }) },
		{ key = "6", mods = "LEADER", action = action({ ActivateTab = 5 }) },
		{ key = "7", mods = "LEADER", action = action({ ActivateTab = 6 }) },
		{ key = "8", mods = "LEADER", action = action({ ActivateTab = 7 }) },
		{ key = "9", mods = "LEADER", action = action({ ActivateTab = 8 }) },
		{ key = "X", mods = "LEADER|SHIFT", action = action({ CloseCurrentTab = { confirm = true } }) },
		{ key = "x", mods = "LEADER", action = action({ CloseCurrentPane = { confirm = true } }) },

		{ key = "Enter", mods = "CMD", action = "ToggleFullScreen" },
		{ key = "v", mods = "CTRL|SHIFT", action = "Paste" },
		{ key = "c", mods = "CTRL|SHIFT", action = "Copy" },

		-- Custom events
		{
			key = "u",
			mods = "CMD",
			action = wezterm.action.EmitEvent("toggle-opacity"),
		},

		-- Enter resize_pane key table. Escape to leave
		{
			key = "q",
			mods = "SHIFT|CTRL",
			action = wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
		},
	},

	key_tables = {
		resize_pane = {
			{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
			{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
			{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
			{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
			{ key = "Escape", action = "PopKeyTable" },
		},
	},
}
