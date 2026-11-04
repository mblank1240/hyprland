-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Old config had `env = QT_QPA_PLATFORM=wayland steam`, which was malformed
-- (it never actually set QT_QPA_PLATFORM). This is the intended version:
-- prefer Wayland, fall back to X11 for Qt apps that can't do Wayland.
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

-- From env.conf (which was never sourced). Uncomment to enable Kvantum styling.
-- hl.env("QT_STYLE_OVERRIDE", "kvantum")
