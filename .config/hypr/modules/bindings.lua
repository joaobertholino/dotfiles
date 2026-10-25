local terminal = "alacritty"
local launcher = "hyprlauncher -t"
local mod = "SUPER"

local function bind(key, dispatcher, opts)
    hl.bind(mod .. " + " .. key, dispatcher, opts)
end

bind("ALT + E", hl.dsp.exec_cmd("emacs"))
bind("RETURN", hl.dsp.exec_cmd(terminal))
bind("ALT + C", hl.dsp.exec_cmd("qalculate-gtk"))
bind("ALT + B", hl.dsp.exec_cmd("zen-browser"))
bind("ALT + X", hl.dsp.exec_cmd("xournalpp"))
bind("SPACE", hl.dsp.exec_cmd(launcher))
bind("ESCAPE", hl.dsp.exec_cmd("hyprctl reload"))
bind("ALT + Q", hl.dsp.exit())
bind("ALT + R", hl.dsp.exec_cmd("hyprctl reload"))
bind("ALT + O", hl.dsp.exec_cmd("/home/joaob/.config/hypr/scripts/toggle-orientation.sh"))
hl.bind("PRINT", hl.dsp.exec_cmd("/home/joaob/.config/hypr/scripts/screenshot.sh"))

-- Símbolos matemáticos: SUPER + ALT + número; com SHIFT, operadores e cálculo.
local math_symbol = "/home/joaob/.config/hypr/scripts/insert-math-symbol.sh "
local math_symbols = {
    ["1"] = "∀", ["2"] = "∃", ["3"] = "∈", ["4"] = "∉", ["5"] = "∩",
    ["6"] = "∪", ["7"] = "→", ["8"] = "↔", ["9"] = "≤", ["0"] = "≥",
}
local math_symbols_shift = {
    ["1"] = "≠", ["2"] = "±", ["3"] = "×", ["4"] = "÷", ["5"] = "√",
    ["6"] = "∞", ["7"] = "∑", ["8"] = "∏", ["9"] = "∫", ["0"] = "∂",
}
for key, symbol in pairs(math_symbols) do
    bind("ALT + " .. key, hl.dsp.exec_cmd(math_symbol .. symbol))
end
for key, symbol in pairs(math_symbols_shift) do
    bind("ALT + SHIFT + " .. key, hl.dsp.exec_cmd(math_symbol .. symbol))
end

bind("W", hl.dsp.window.close())
bind("SHIFT + W", hl.dsp.window.kill())
bind("M", hl.dsp.window.fullscreen({ action = "toggle" }))
bind("Y", hl.dsp.layout("swapwithmaster"))
bind("G", hl.dsp.layout("focusmaster"))
bind("T", hl.dsp.window.float({ action = "toggle" }))
bind("SHIFT + T", hl.dsp.window.pseudo())
bind("S", hl.dsp.window.float({ action = "toggle" }))
bind("F", hl.dsp.window.fullscreen({ action = "toggle" }))
bind("CTRL + Y", hl.dsp.window.pin({ action = "toggle" }))

local directions = { H = "left", J = "down", K = "up", L = "right" }
for key, direction in pairs(directions) do
    bind(key, hl.dsp.focus({ direction = direction }))
    bind("SHIFT + " .. key, hl.dsp.exec_cmd("hyprctl dispatch movewindow " .. direction))
    bind("ALT + SHIFT + " .. key, hl.dsp.exec_cmd("hyprctl dispatch swapwindow " .. direction))
end

bind("P", hl.dsp.layout("togglesplit"))
bind("B", hl.dsp.exec_cmd("hyprctl dispatch layoutmsg focusmaster"))
bind("COMMA", hl.dsp.exec_cmd("hyprctl dispatch cyclenext"))
bind("PERIOD", hl.dsp.exec_cmd("hyprctl dispatch cycleprev"))
bind("BRACKETLEFT", hl.dsp.focus({ workspace = "e-1" }))
bind("BRACKETRIGHT", hl.dsp.focus({ workspace = "e+1" }))
bind("GRAVE", hl.dsp.focus({ workspace = "previous" }))
bind("TAB", hl.dsp.focus({ workspace = "previous" }))
bind("O", hl.dsp.exec_cmd("hyprctl dispatch focuscurrentorlast"))
bind("I", hl.dsp.exec_cmd("hyprctl dispatch focusurgentorlast"))

for i = 1, 10 do
    local key = i % 10
    bind(tostring(key), hl.dsp.focus({ workspace = i }))
    bind("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

bind("ALT + H", hl.dsp.window.resize({ x = -20, y = 0 }))
bind("ALT + J", hl.dsp.window.resize({ x = 0, y = 20 }))
bind("ALT + K", hl.dsp.window.resize({ x = 0, y = -20 }))
bind("ALT + L", hl.dsp.window.resize({ x = 20, y = 0 }))
bind("LEFT", hl.dsp.window.move({ x = -20, y = 0 }))
bind("DOWN", hl.dsp.window.move({ x = 0, y = 20 }))
bind("UP", hl.dsp.window.move({ x = 0, y = -20 }))
bind("RIGHT", hl.dsp.window.move({ x = 20, y = 0 }))

hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
