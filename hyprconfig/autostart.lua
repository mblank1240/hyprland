-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- Runs once at startup (the Lua equivalent of exec-once).

local startup = {
    "waybar",
    "swaync",       -- notifications (claims the D-Bus name before dunst can)
    "wal -R",       -- restore last pywal colorscheme
    "hypridle",
    "hyprpaper",
    "wayvnc",

    -- Clipboard history (SUPER+SHIFT+V)
    "wl-paste --type text  --watch cliphist store",
    "wl-paste --type image --watch cliphist store",

    -- Scratchpad apps; rules.lua sends their windows to special:magic
    "discord",
    "spotify-launcher",

    -- Disabled during the migration, re-enable if you need them:
    -- "pywal",        -- not a command; `wal -R` above is what restores pywal
    -- "swww-daemon",  -- not installed, and would fight hyprpaper for the wallpaper
    -- "tailscale up", -- tailscaled (system service) already keeps you connected
}

hl.on("hyprland.start", function()
    for _, cmd in ipairs(startup) do
        hl.exec_cmd(cmd)
    end
end)
