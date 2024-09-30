local wezterm = require("wezterm")
local action = wezterm.action

wezterm.on("toggle-window-background", function(window)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity and not overrides.macos_window_background_blur then
		overrides.window_background_opacity = 0.75
		overrides.macos_window_background_blur = 0
	else
		overrides.window_background_opacity = nil
		overrides.macos_window_background_blur = nil
	end
	window:set_config_overrides(overrides)
end)

wezterm.on("toggle-cursor-color", function(window)
	local overrides = window:get_config_overrides() or {}
	if overrides.force_reverse_video_cursor then
		overrides.force_reverse_video_cursor = false
	else
		overrides.force_reverse_video_cursor = true
	end
	window:set_config_overrides(overrides)
end)

return {
	-- Font --

	-- font = wezterm.font("FiraCode Nerd Font"),
	-- font = wezterm.font("Operator Mono Lig"),

	-- HackGen35
	-- font = wezterm.font("HackGen35 Console NFJ"),
	-- font_size = 14.5,
	-- cell_width = 1.10,
	-- line_height = 1.15,

	-- Hack
	font = wezterm.font("Hack Nerd Font"),
	font_size = 12.5,
	cell_width = 1.05,
	line_height = 1.35,

	-- MesloLGS
	-- font = wezterm.font("MesloLGS NF"),
	-- font_size = 14.0,
	-- cell_width = 1.10,
	-- line_height = 1.1,

	-- SF Mono
	-- font = wezterm.font("SFMono Nerd Font"),
	-- font_size = 14,
	-- cell_width = 1.05,
	-- line_height = 1.15,

	-- SFMono Square
	-- font = wezterm.font("SF Mono Square"),
	-- font_size = 16.0,
	-- cell_width = 1.00,
	-- line_height = 1.30,

	-- Window --
	initial_cols = 141,
	initial_rows = 120,
	window_background_opacity = 0.94,
	macos_window_background_blur = 100,
	window_decorations = "RESIZE",
	window_padding = { left = 8, right = 8, top = 8, bottom = 8 },
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
		font = wezterm.font({ family = "Hack Nerd Font", weight = "Bold" }),

		-- The size of the font in the tab bar.
		font_size = 13.0,

		-- The overall background color of the tab bar when the window is focused
		active_titlebar_bg = "#151921",
	},

	-- Pane --
	inactive_pane_hsb = {
		hue = 1.0,
		saturation = 1.0,
		brightness = 0.40,
		-- brightness = 1.00,
	},

	-- Text --
	text_blink_rate = 0, -- disable blinking text (for lazygit)

	-- Cursor --
	cursor_blink_rate = 1000,
	cursor_thickness = 3,
	-- enable swapping the foreground color and the background color
	force_reverse_video_cursor = false,

	-- Color scheme --
	-- 自分の好きなテーマ探す https://wezfurlong.org/wezterm/colorschemes/index.html
	color_scheme = "Catppuccin Mocha",
	-- color_scheme = "OneDark (base16)",
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
	-- leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 },
	disable_default_key_bindings = true,

	keys = {
		-- { key = "t", mods = "CMD", action = wezterm.action.DisableDefaultAssignment },
		{ key = "Enter", mods = "CMD", action = "ToggleFullScreen" },
		{ key = "c", mods = "CMD", action = action({ CopyTo = "Clipboard" }) },
		{ key = "v", mods = "CMD", action = action({ PasteFrom = "Clipboard" }) },
		{ key = "h", mods = "CMD", action = action.HideApplication },
		{ key = "n", mods = "CMD", action = action.SpawnCommandInNewWindow({}) },
		{ key = "q", mods = "CMD", action = action.CloseCurrentPane({ confirm = true }) },
		{ key = "Q", mods = "CMD", action = action.QuitApplication },
		{ key = "-", mods = "CMD", action = "DecreaseFontSize" },
		{ key = "=", mods = "CMD", action = "IncreaseFontSize" },

		-- Neovim
		{ key = "/", mods = "CTRL", action = action({ SendString = "\x1f" }) }, -- Comment out: <C-/>
		{ key = "a", mods = "CMD", action = action({ SendString = "\x67\x67\x56\x47" }) }, -- Select all: ggVG
		{ key = "k", mods = "CTRL|SHIFT", action = action({ SendString = "\x20\x69\x6b" }) }, -- Move text up: <space>ik
		{ key = "j", mods = "CTRL|SHIFT", action = action({ SendString = "\x20\x69\x6a" }) }, -- Move text down: <space>ij

		-- Custom events
		{
			key = "u",
			mods = "CMD",
			action = action.EmitEvent("toggle-window-background"),
		},
		{ key = "0", mods = "CMD", action = action.EmitEvent("toggle-cursor-color") },

		-- Enter resize_pane key table. Escape to leave
		{
			key = "q",
			mods = "SHIFT|CTRL",
			action = action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
		},

		-- Tmux
		-- \x11: <C-q>
		{ key = "s", mods = "CMD", action = action({ SendString = "\x11s" }) },
		{ key = "f", mods = "CMD", action = action({ SendString = "\x11/" }) },
		{ key = "t", mods = "CMD", action = action({ SendString = "\x11c" }) },
		{ key = "d", mods = "CMD", action = action({ SendString = "\x11|" }) },
		{ key = "D", mods = "CMD", action = action({ SendString = "\x11-" }) },
		{ key = "w", mods = "CMD", action = action({ SendString = "\x11d" }) },
		{ key = "W", mods = "CMD", action = action({ SendString = "\x11D" }) },
		{ key = "r", mods = "CMD", action = action({ SendString = "\x11r" }) },
		{ key = "R", mods = "CMD", action = action({ SendString = "\x11R" }) },
		{ key = "]", mods = "CMD", action = action({ SendString = "\x11n" }) },
		{ key = "[", mods = "CMD", action = action({ SendString = "\x11p" }) },
		{ key = "o", mods = "CMD", action = action({ SendString = "\x11o" }) },
		{ key = "O", mods = "CMD", action = action({ SendString = "\x11O" }) },
		-- { key = "l", mods = "ALT", action = action({ SendString = "\x11l" }) },
		-- { key = "h", mods = "ALT", action = action({ SendString = "\x11h" }) },
		-- { key = "j", mods = "ALT", action = action({ SendString = "\x11j" }) },
		-- { key = "k", mods = "ALT", action = action({ SendString = "\x11k" }) },
		{ key = "m", mods = "CMD", action = action({ SendString = "\x11m" }) },
		{ key = "z", mods = "CMD", action = action({ SendString = "\x11z" }) },
		{ key = "1", mods = "CMD", action = action({ SendString = "\x111" }) },
		{ key = "2", mods = "CMD", action = action({ SendString = "\x112" }) },
		{ key = "3", mods = "CMD", action = action({ SendString = "\x113" }) },
		{ key = "4", mods = "CMD", action = action({ SendString = "\x114" }) },
		{ key = "5", mods = "CMD", action = action({ SendString = "\x115" }) },
		{ key = "6", mods = "CMD", action = action({ SendString = "\x116" }) },
		{ key = "7", mods = "CMD", action = action({ SendString = "\x117" }) },
		{ key = "8", mods = "CMD", action = action({ SendString = "\x118" }) },
		{ key = "9", mods = "CMD", action = action({ SendString = "\x119" }) },

		-- Tmux-like key bindings
		-- { key = "t", mods = "CMD", action = action({ SpawnTab = "CurrentPaneDomain" }) },
		-- { key = "w", mods = "CMD", action = action({ CloseCurrentPane = { confirm = true } }) },
		-- { key = "w", mods = "CMD|SHIFT", action = action({ CloseCurrentTab = { confirm = true } }) },
		--   {
		-- 	key = "d",
		-- 	mods = "CMD",
		-- 	action = action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		-- },
		-- {
		-- 	key = "D",
		-- 	mods = "CMD|SHIFT",
		-- 	action = action({ SplitVertical = { domain = "CurrentPaneDomain" } }),
		-- },
		-- { key = "-", mods = "LEADER", action = action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		-- {
		-- 	key = "|",
		-- 	mods = "LEADER",
		-- 	action = action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
		-- },
		-- { key = "z", mods = "CMD", action = "TogglePaneZoomState" },
		-- {
		-- 	key = "r",
		-- 	mods = "CMD",
		-- 	action = action.PromptInputLine({
		-- 		description = "Enter new name for tab",
		-- 		action = action_callback(function(window, pane, line)
		-- 			-- line will be `nil` if they hit escape without entering anything
		-- 			-- An empty string if they just hit enter
		-- 			-- Or the actual line of text they wrote
		-- 			if line then
		-- 				window:active_tab():set_title(line)
		-- 			end
		-- 		end),
		-- 	}),
		-- },
		-- {
		-- 	key = "r",
		-- 	mods = "LEADER",
		-- 	action = action.PromptInputLine({
		-- 		description = "Enter new name for tab",
		-- 		action = action_callback(function(window, pane, line)
		-- 			-- line will be `nil` if they hit escape without entering anything
		-- 			-- An empty string if they just hit enter
		-- 			-- Or the actual line of text they wrote
		-- 			if line then
		-- 				window:active_tab():set_title(line)
		-- 			end
		-- 		end),
		-- 	}),
		-- },
		-- { key = "m", mods = "LEADER", action = "TogglePaneZoomState" },
		-- { key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
		-- { key = "[", mods = "LEADER", action = "ActivateCopyMode" },
		-- { key = "c", mods = "LEADER", action = action({ SpawnTab = "CurrentPaneDomain" }) },
		-- { key = "n", mods = "LEADER", action = action({ ActivateTabRelative = 1 }) },
		-- { key = "p", mods = "LEADER", action = action({ ActivateTabRelative = -1 }) },
		-- { key = "h", mods = "LEADER", action = action({ ActivatePaneDirection = "Left" }) },
		-- { key = "j", mods = "LEADER", action = action({ ActivatePaneDirection = "Down" }) },
		-- { key = "k", mods = "LEADER", action = action({ ActivatePaneDirection = "Up" }) },
		-- { key = "l", mods = "LEADER", action = action({ ActivatePaneDirection = "Right" }) },
		-- { key = "1", mods = "LEADER", action = action({ ActivateTab = 0 }) },
		-- { key = "2", mods = "LEADER", action = action({ ActivateTab = 1 }) },
		-- { key = "3", mods = "LEADER", action = action({ ActivateTab = 2 }) },
		-- { key = "4", mods = "LEADER", action = action({ ActivateTab = 3 }) },
		-- { key = "5", mods = "LEADER", action = action({ ActivateTab = 4 }) },
		-- { key = "6", mods = "LEADER", action = action({ ActivateTab = 5 }) },
		-- { key = "7", mods = "LEADER", action = action({ ActivateTab = 6 }) },
		-- { key = "8", mods = "LEADER", action = action({ ActivateTab = 7 }) },
		-- { key = "9", mods = "LEADER", action = action({ ActivateTab = 8 }) },
		-- { key = "X", mods = "LEADER|SHIFT", action = action({ CloseCurrentTab = { confirm = true } }) },
		-- { key = "x", mods = "LEADER", action = action({ CloseCurrentPane = { confirm = true } }) },
		-- { key = "]", mods = "LEADER", action = "QuickSelect" },
		-- { key = "1", mods = "CMD", action = action({ ActivateTab = 0 }) },
		-- { key = "2", mods = "CMD", action = action({ ActivateTab = 1 }) },
		-- { key = "3", mods = "CMD", action = action({ ActivateTab = 2 }) },
		-- { key = "4", mods = "CMD", action = action({ ActivateTab = 3 }) },
		-- { key = "5", mods = "CMD", action = action({ ActivateTab = 4 }) },
		-- { key = "6", mods = "CMD", action = action({ ActivateTab = 5 }) },
		-- { key = "7", mods = "CMD", action = action({ ActivateTab = 6 }) },
		-- { key = "8", mods = "CMD", action = action({ ActivateTab = 7 }) },
		-- { key = "9", mods = "CMD", action = action({ ActivateTab = 8 }) },
		-- { key = "]", mods = "CMD", action = action({ ActivateTabRelative = 1 }) },
		-- { key = "[", mods = "CMD", action = action({ ActivateTabRelative = -1 }) },
	},

	key_tables = {
		search_mode = {
			{ key = "Enter", mods = "NONE", action = action.CopyMode("NextMatch") },
			{ key = "Escape", mods = "NONE", action = action.CopyMode("Close") },
			{ key = "g", mods = "CMD", action = action.CopyMode("NextMatch") },
			{ key = "g", mods = "CMD|SHIFT", action = action.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = action.CopyMode("CycleMatchType") },
			{ key = "u", mods = "CTRL", action = action.CopyMode("ClearPattern") },
			{
				key = "PageUp",
				mods = "NONE",
				action = action.CopyMode("PriorMatchPage"),
			},
			{
				key = "PageDown",
				mods = "NONE",
				action = action.CopyMode("NextMatchPage"),
			},
			{ key = "UpArrow", mods = "NONE", action = action.CopyMode("PriorMatch") },
			{ key = "DownArrow", mods = "NONE", action = action.CopyMode("NextMatch") },
		},
		resize_pane = {
			{ key = "h", action = action.AdjustPaneSize({ "Left", 5 }) },
			{ key = "j", action = action.AdjustPaneSize({ "Down", 5 }) },
			{ key = "k", action = action.AdjustPaneSize({ "Up", 5 }) },
			{ key = "l", action = action.AdjustPaneSize({ "Right", 5 }) },
			{ key = "Escape", action = "PopKeyTable" },
		},
	},
}
