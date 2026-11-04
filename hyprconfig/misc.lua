-- See https://wiki.hypr.land/Configuring/Basics/Variables/#misc

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- 0 or 1 disables the anime mascot wallpapers
        disable_hyprland_logo   = false,

        -- If hyprlock ever crashes, allow a fresh hyprlock to take over the
        -- locked session (run from a TTY, see README) instead of being stuck.
        allow_session_lock_restore = true,
    },
})

-- Permissions (require a full Hyprland restart to take effect):
-- hl.config({ ecosystem = { enforce_permissions = true } })
-- hl.permission({ ... })  -- see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
