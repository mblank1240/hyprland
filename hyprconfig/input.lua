-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = -0.8, -- -1.0 to 1.0, 0 = no modification

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

-- Per-device overrides. The old config only had the wiki's placeholder
-- "epic-mouse-v1", which doesn't exist on this machine. Your real mouse:
-- hl.device({
--     name        = "logitech-g502-hero-gaming-mouse",
--     sensitivity = -0.5,
-- })
