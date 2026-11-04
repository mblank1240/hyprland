-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- Every bind has a description, so `hyprctl binds` doubles as a cheat sheet.

local vars = require("hyprconfig.vars")
local mod  = vars.mainMod

hl.config({
    binds = {
        -- Pressing the key of the workspace you're already on jumps back to the previous one
        workspace_back_and_forth = true,
    },
})

-- bind("Q", dsp, "desc")            -> SUPER + Q
-- bind("SHIFT + Q", dsp, "desc")    -> SUPER + SHIFT + Q
-- bind("!Print", dsp, "desc")       -> Print (leading ! = no SUPER)
local function bind(keys, dispatcher, desc, opts)
    if keys:sub(1, 1) == "!" then
        keys = keys:sub(2)
    else
        keys = mod .. " + " .. keys
    end
    opts = opts or {}
    opts.description = desc
    return hl.bind(keys, dispatcher, opts)
end

local exec = hl.dsp.exec_cmd
local dirs = { h = "left", j = "down", k = "up", l = "right" }

-------------------------------------------------------------------------------
-- Apps
-------------------------------------------------------------------------------
bind("Q",     exec(vars.terminal),    "Terminal")
bind("E",     exec(vars.fileManager), "File manager")
bind("SPACE", exec(vars.menu),        "App launcher")
bind("O",     exec("hyprlock"),       "Lock screen")
bind("N",     exec("swaync-client -t -sw"), "Notification center")
bind("SHIFT + C", exec("hyprpicker -a"),    "Color picker (copies hex)")
bind("SHIFT + V",
     exec("cliphist list | rofi -dmenu -p clipboard -display-columns 2 | cliphist decode | wl-copy"),
     "Clipboard history")

-------------------------------------------------------------------------------
-- Window state
-------------------------------------------------------------------------------
bind("C", hl.dsp.window.close(),                     "Close window")
bind("V", hl.dsp.window.float({ action = "toggle" }), "Toggle floating")
bind("P", hl.dsp.window.pseudo(),                    "Pseudotile (dwindle)")
bind("F", hl.dsp.window.fullscreen({ mode = "fullscreen" }), "Fullscreen")
bind("SHIFT + F", hl.dsp.window.fullscreen({ mode = "maximized" }), "Maximize (keep bar & gaps)")

-------------------------------------------------------------------------------
-- Focus / move / swap  (hjkl)
-- Moving past the screen edge carries the window onto the other monitor.
-------------------------------------------------------------------------------
for k, dir in pairs(dirs) do
    bind(k,              hl.dsp.focus({ direction = dir }),        "Focus " .. dir)
    bind("SHIFT + " .. k, hl.dsp.window.move({ direction = dir }), "Move window " .. dir)
    bind("CTRL + " .. k,  hl.dsp.window.swap({ direction = dir }), "Swap window " .. dir)
end

-------------------------------------------------------------------------------
-- Monitors
-------------------------------------------------------------------------------
bind("comma",          hl.dsp.focus({ monitor = "-1" }),       "Focus previous monitor")
bind("period",         hl.dsp.focus({ monitor = "+1" }),       "Focus next monitor")
bind("SHIFT + comma",  hl.dsp.window.move({ monitor = "-1" }), "Send window to previous monitor")
bind("SHIFT + period", hl.dsp.window.move({ monitor = "+1" }), "Send window to next monitor")
bind("X", hl.dsp.workspace.swap_monitors({ monitor1 = "DP-5", monitor2 = "DP-6" }),
     "Swap workspaces between monitors")

-------------------------------------------------------------------------------
-- Workspaces
-------------------------------------------------------------------------------
for i = 1, 10 do
    local n = i % 10 -- workspace 10 is on key 0
    bind(tostring(n),         hl.dsp.focus({ workspace = i }),       "Go to workspace " .. i)
    bind("SHIFT + " .. n,     hl.dsp.window.move({ workspace = i }), "Move window to workspace " .. i)
    bind("CTRL + " .. n,      hl.dsp.window.move({ workspace = i, follow = false }),
         "Send window to workspace " .. i .. " (stay here)")
end

bind("Tab",        hl.dsp.focus({ workspace = "previous" }), "Previous workspace")
bind("mouse_down", hl.dsp.focus({ workspace = "e+1" }),      "Next workspace")
bind("mouse_up",   hl.dsp.focus({ workspace = "e-1" }),      "Previous existing workspace")

-- Scratchpad (Discord + Spotify live here)
bind("S",         hl.dsp.workspace.toggle_special("magic"),              "Toggle scratchpad")
bind("SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }),   "Move window to scratchpad")

-------------------------------------------------------------------------------
-- Groups (tabbed windows)
-------------------------------------------------------------------------------
bind("W",            hl.dsp.group.toggle(),                       "Toggle group (tabs)")
bind("bracketright", hl.dsp.group.next(),                         "Next tab in group")
bind("bracketleft",  hl.dsp.group.prev(),                         "Previous tab in group")
bind("ALT + W",      hl.dsp.window.move({ out_of_group = true }), "Pull window out of group")
for k, dir in pairs(dirs) do
    bind("ALT + " .. k, hl.dsp.window.move({ into_group = dir }), "Move window into group " .. dir)
end

-------------------------------------------------------------------------------
-- Resize mode: SUPER+R, then hjkl (hold to repeat), Esc/Enter to leave
-------------------------------------------------------------------------------
bind("R", hl.dsp.submap("resize"), "Enter resize mode")

hl.define_submap("resize", function()
    local step = 40
    local delta = {
        h = { -step, 0, "Narrower" }, l = { step, 0, "Wider" },
        k = { 0, -step, "Shorter" },  j = { 0, step, "Taller" },
    }
    for k, d in pairs(delta) do
        hl.bind(k, hl.dsp.window.resize({ x = d[1], y = d[2], relative = true }),
                { repeating = true, description = d[3] })
    end
    hl.bind("escape", hl.dsp.submap("reset"), { description = "Exit resize mode" })
    hl.bind("Return", hl.dsp.submap("reset"), { description = "Exit resize mode" })
end)

-------------------------------------------------------------------------------
-- Mouse
-------------------------------------------------------------------------------
bind("mouse:272", hl.dsp.window.drag(),   "Drag window",   { mouse = true })
bind("mouse:273", hl.dsp.window.resize(), "Resize window", { mouse = true })

-------------------------------------------------------------------------------
-- Screenshots  (saved to ~/Pictures/Screenshots and copied to clipboard)
-------------------------------------------------------------------------------
local function screenshot(grimArgs)
    return function()
        local file = os.getenv("HOME") .. "/Pictures/Screenshots/" .. os.date("%Y-%m-%d_%H-%M-%S") .. ".png"
        hl.exec_cmd(string.format(
            [[mkdir -p ~/Pictures/Screenshots && grim %s '%s' && wl-copy < '%s' && notify-send -i '%s' 'Screenshot saved' '%s']],
            grimArgs, file, file, file, file))
    end
end

bind("!Print", function()
    hl.exec_cmd([[grim -g "$(slurp -d)" - | wl-copy && notify-send 'Screenshot copied']])
end, "Screenshot region → clipboard")
bind("!SHIFT + Print", screenshot([[-g "$(slurp -d)"]]), "Screenshot region → file + clipboard")
bind("Print", function()
    local mon = hl.get_active_monitor()
    if mon then screenshot("-o " .. mon.name)() end
end, "Screenshot current monitor → file + clipboard")

-------------------------------------------------------------------------------
-- Media keys (also work on the lock screen)
-------------------------------------------------------------------------------
local held   = function() return { locked = true, repeating = true } end
local locked = function() return { locked = true } end

bind("!XF86AudioRaiseVolume", exec("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), "Volume up",   held())
bind("!XF86AudioLowerVolume", exec("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      "Volume down", held())
bind("!XF86AudioMute",        exec("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     "Mute",        held())
bind("!XF86AudioMicMute",     exec("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   "Mute mic",    held())

bind("!XF86AudioNext",  exec("playerctl next"),       "Next track",     locked())
bind("!XF86AudioPause", exec("playerctl play-pause"), "Play / pause",   locked())
bind("!XF86AudioPlay",  exec("playerctl play-pause"), "Play / pause",   locked())
bind("!XF86AudioPrev",  exec("playerctl previous"),   "Previous track", locked())
