-- Keep the standard pen behavior in other applications, including Xournal++.
local function update_tablet_buttons()
    hl.dispatch(hl.dsp.exec_cmd("/home/joaob/.config/hypr/scripts/zathura-tablet-buttons.py"))
end
hl.on("window.active", update_tablet_buttons)
hl.on("config.reloaded", update_tablet_buttons)
update_tablet_buttons()
