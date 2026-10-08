hl.config({
    input = {
        kb_layout = "br",
        follow_mouse = 1,
        sensitivity = 0,
        accel_profile = "flat",
        numlock_by_default = true,
        touchpad = { natural_scroll = false, tap_to_click = true },
        tablet = {
            left_handed = true,
            output = "HDMI-A-1",
            relative_input = false,
            transform = 1,
        },
    },
})

hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

hl.device({
    name = "wacom-one-by-wacom-s-pen",
    left_handed = true,
    output = "HDMI-A-1",
    transform = 1,
})
