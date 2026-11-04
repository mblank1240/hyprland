-- Look and feel: general, decoration, animations.
-- See https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 5,

        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
            inactive_border = "rgba(595959aa)",
        },

        -- Resize windows by click-dragging borders/gaps
        resize_on_border = false,

        -- Only applies to windows with the `immediate` rule (Steam games, see rules.lua)
        allow_tearing = true,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 0.95,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- Curves -- see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
local function bezier(name, x0, y0, x1, y1)
    hl.curve(name, { type = "bezier", points = { { x0, y0 }, { x1, y1 } } })
end

bezier("easeOutQuint",   0.23, 1,    0.32, 1)
bezier("easeInOutCubic", 0.65, 0.05, 0.36, 1)
bezier("linear",         0,    0,    1,    1)
bezier("almostLinear",   0.5,  0.5,  0.75, 1)
bezier("quick",          0.15, 0,    0.1,  1)

-- { leaf, speed, curve, style? }
local animations = {
    { "global",        10,   "default" },
    { "border",        5.39, "easeOutQuint" },
    { "windows",       4.79, "easeOutQuint" },
    { "windowsIn",     4.1,  "easeOutQuint", "popin 87%" },
    { "windowsOut",    1.49, "linear",       "popin 87%" },
    { "fadeIn",        1.73, "almostLinear" },
    { "fadeOut",       1.46, "almostLinear" },
    { "fade",          3.03, "quick" },
    { "layers",        3.81, "easeOutQuint" },
    { "layersIn",      4,    "easeOutQuint", "fade" },
    { "layersOut",     1.5,  "linear",       "fade" },
    { "fadeLayersIn",  1.79, "almostLinear" },
    { "fadeLayersOut", 1.39, "almostLinear" },
    { "workspaces",    1.94, "almostLinear", "fade" },
    { "workspacesIn",  1.21, "almostLinear", "fade" },
    { "workspacesOut", 1.94, "almostLinear", "fade" },
    { "zoomFactor",    7,    "quick" },
}

for _, a in ipairs(animations) do
    hl.animation({ leaf = a[1], enabled = true, speed = a[2], bezier = a[3], style = a[4] })
end
