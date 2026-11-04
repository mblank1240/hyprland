-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- vrr: 0 = off, 1 = always, 2 = fullscreen only (avoids desktop flicker)

hl.monitor({
    output   = "DP-5",
    mode     = "2560x1440@74.92Hz",
    position = "0x0",
    scale    = "auto",
    vrr      = 2,
})

hl.monitor({
    output   = "DP-6",
    mode     = "2560x1440@74.92Hz",
    position = "2560x0",
    scale    = "auto",
    vrr      = 2,
})
