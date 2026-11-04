-- See https://wiki.hypr.land/Configuring/Basics/Variables/#misc

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- 0 or 1 disables the anime mascot wallpapers
        disable_hyprland_logo   = false,
    },
})

-- Permissions (require a full Hyprland restart to take effect):
-- hl.config({ ecosystem = { enforce_permissions = true } })
-- hl.permission({ ... })  -- see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
