hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 1,
        col = { active_border = "rgba(737373ff)", inactive_border = "rgba(262626ff)" },
        resize_on_border = false,
        hover_icon_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },
    decoration = {
        rounding = 0,
        active_opacity = 1.0,
        inactive_opacity = 1.0,
        shadow = { enabled = false },
        blur = { enabled = false },
    },
    animations = { enabled = true},
    dwindle = { preserve_split = true, smart_split = false },
    misc = { force_default_wallpaper = 0, disable_hyprland_logo = true },
})

hl.curve("ease_out", { type = "bezier", points = { {0.16, 1}, {0.3, 1} } })
hl.curve("ease_in", { type = "bezier", points = { {0.7, 0}, {0.84, 0} } })
hl.curve("ease_in_out", { type = "bezier", points = { {0.65, 0}, {0.35, 1} } })
hl.curve("launcher", { type = "bezier", points = { {0.2, 0.9}, {0.2, 1} } })

hl.animation({ leaf = "global", enabled = true, speed = 3, bezier = "ease_out" })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "ease_out", style = "popin 92%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3, bezier = "ease_out", style = "popin 92%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2, bezier = "ease_in", style = "popin 96%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 2, bezier = "ease_in_out" })

hl.animation({ leaf = "layers", enabled = true, speed = 2, bezier = "launcher", style = "popin" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 2, bezier = "launcher", style = "popin" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2, bezier = "ease_in", style = "popin" })

hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "ease_in_out" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "ease_out" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 2, bezier = "ease_in" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 1, bezier = "ease_in_out" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 1, bezier = "ease_in_out" })
hl.animation({ leaf = "fadeGlow", enabled = true, speed = 1, bezier = "ease_in_out" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 2, bezier = "ease_in_out" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 2, bezier = "ease_in_out" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "ease_out" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 2, bezier = "ease_in" })
hl.animation({ leaf = "fadePopups", enabled = true, speed = 1, bezier = "ease_in_out" })
hl.animation({ leaf = "fadePopupsIn", enabled = true, speed = 1, bezier = "ease_out" })
hl.animation({ leaf = "fadePopupsOut", enabled = true, speed = 1, bezier = "ease_in" })
hl.animation({ leaf = "fadeDpms", enabled = true, speed = 1, bezier = "ease_in_out" })

hl.animation({ leaf = "border", enabled = true, speed = 2, bezier = "ease_in_out" })
hl.animation({ leaf = "borderangle", enabled = false })
hl.animation({ leaf = "shadowangle", enabled = false })
hl.animation({ leaf = "glowangle", enabled = false })

hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "ease_in_out", style = "slidefade 15%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3, bezier = "ease_in_out", style = "slidefade 15%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3, bezier = "ease_in_out", style = "slidefade 15%" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "ease_in_out", style = "slidefadevert 15%" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 3, bezier = "ease_out", style = "slidefadevert 15%" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2, bezier = "ease_in", style = "slidefadevert 15%" })

hl.animation({ leaf = "zoomFactor", enabled = true, speed = 2, bezier = "ease_in_out" })
hl.animation({ leaf = "monitorAdded", enabled = true, speed = 3, bezier = "ease_out" })
