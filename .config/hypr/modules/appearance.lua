hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 1,
        col = { active_border = "rgba(303030ee)", inactive_border = "rgba(000000ff)" },
        resize_on_border = false,
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

hl.curve("ease", { type = "bezier", points = { {0.25, 0.1}, {0.25, 1} } })
hl.animation({ leaf = "global", enabled = true, speed = 2, bezier = "ease" })
hl.animation({ leaf = "windows", enabled = true, speed = 2, bezier = "ease" })
hl.animation({ leaf = "fade", enabled = true, speed = 2, bezier = "ease" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "ease" })
