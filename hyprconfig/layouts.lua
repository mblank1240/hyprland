-- Layout settings.
-- Dwindle: https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
-- Master:  https://wiki.hypr.land/Configuring/Layouts/Master-Layout/

hl.config({
    -- Your old dwindle block was commented out (and missing its opening brace),
    -- so these are left off to keep behavior identical. Uncomment to enable.
    -- dwindle = {
    --     pseudotile     = true,
    --     preserve_split = true,
    -- },

    master = {
        new_status = "master",
    },
})

-- "Smart gaps": no gaps/border/rounding when a workspace has a single tiled window.
-- Uncomment all of these to enable.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name = "no-gaps-wtv1", match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ name = "no-gaps-f1",   match = { float = false, workspace = "f[1]" },   border_size = 0, rounding = 0 })
