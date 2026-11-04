-- Window, layer and workspace rules.
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Discord and Spotify open silently in the scratchpad (SUPER+S)
local scratchpadApps = {
    discord = "^(discord)$",
    spotify = "(?i)^(spotify)$", -- class is "Spotify" on XWayland, "spotify" on Wayland
}

for name, class in pairs(scratchpadApps) do
    hl.window_rule({
        name      = "scratchpad-" .. name,
        match     = { class = class },
        workspace = "special:magic silent",
    })
end

-- Spotify sets its window class *after* the window opens, so the rule above can
-- miss it. Catch the late class change and move it ourselves.
hl.on("window.class", function(w)
    if w and w.class and w.class:lower() == "spotify"
       and not (w.workspace and w.workspace.special) then
        hl.dispatch(hl.dsp.window.move({ workspace = "special:magic", follow = false, window = w }))
    end
end)

-- Don't let hypridle lock/blank the screen while anything is fullscreen
-- (videos, games, presentations)
hl.window_rule({
    name         = "idle-inhibit-fullscreen",
    match        = { class = ".*" },
    idle_inhibit = "fullscreen",
})

-- Allow tearing (lower input latency) for Steam games. Needs general.allow_tearing.
hl.window_rule({
    name      = "tearing-steam-games",
    match     = { class = "^(steam_app_.*)$" },
    immediate = true,
})

-- Ignore maximize requests from apps (was commented out in the old config)
-- hl.window_rule({ name = "suppress-maximize", match = { class = ".*" }, suppress_event = "maximize" })

-- Fix some XWayland dragging issues (was commented out in the old config)
-- hl.window_rule({
--     name  = "fix-xwayland-drags",
--     match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
--     no_focus = true,
-- })
