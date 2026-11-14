-- AOC 22B35HM23: SDR/sRGB, 8-bit RGB, native Full HD at 120 Hz.
-- The monitor HDR Mode is simulated; keep normal SDR brightness/saturation.
hl.monitor({
    output = "HDMI-A-1",
    mode = "1920x1080@120",
    position = "auto",
    scale = 1,
    transform = 1,
    vrr = 1,
    bitdepth = 8,
    cm = "srgb",
    sdrbrightness = 1.0,
    sdrsaturation = 1.0,
})
