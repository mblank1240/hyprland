-- Hyprland entry point.
-- Each concern lives in its own module under hyprconfig/; order matters only
-- where noted (vars first, since other modules read from it).
-- Validate changes with:  Hyprland --verify-config -c ~/.config/hypr/hyprland.lua

require("hyprconfig.monitors")
require("hyprconfig.env")
require("hyprconfig.autostart")
require("hyprconfig.appearance")
require("hyprconfig.layouts")
require("hyprconfig.input")
require("hyprconfig.keybinds")
require("hyprconfig.rules")
require("hyprconfig.misc")
