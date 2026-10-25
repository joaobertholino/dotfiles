-- Complementos Hyprland: atalhos adicionais.
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("/home/joaob/.config/hypr/scripts/screenshot.sh window"))
hl.bind("SUPER + PRINT", hl.dsp.exec_cmd("/home/joaob/.config/hypr/scripts/screenshot.sh output"))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("/home/joaob/.config/hypr/scripts/screenshot.sh region clipboard"))
hl.bind("SUPER + ALT + P", hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind("SUPER + ALT + A", hl.dsp.exec_cmd("hyprpwcenter"))
hl.bind("SUPER + ALT + I", hl.dsp.exec_cmd("hyprsysteminfo"))
hl.bind("SUPER + CTRL + ESCAPE", hl.dsp.exec_cmd("hyprshutdown"))
