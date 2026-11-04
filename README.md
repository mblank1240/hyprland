# hyprland

My Hyprland config, written in the Lua config format (Hyprland 0.56+) and split into modules.

```
hypr/
├── hyprland.lua          # entry point, loads the modules in order
├── hypridle.conf         # lock at ~13.5 min, screens off at 20 min
├── hyprpaper.conf
└── hyprconfig/
    ├── vars.lua          # mainMod, terminal, fileManager, menu
    ├── monitors.lua      # DP-5 / DP-6, VRR (fullscreen only)
    ├── env.lua
    ├── autostart.lua     # waybar, swaync, cliphist, discord, spotify, ...
    ├── appearance.lua    # general, decoration, curves, animations
    ├── layouts.lua       # dwindle / master
    ├── input.lua
    ├── keybinds.lua      # every bind has a description (see `hyprctl binds`)
    ├── rules.lua         # scratchpad apps, idle inhibit, tearing for games
    └── misc.lua
```

Validate changes with:

```sh
Hyprland --verify-config -c ~/.config/hypr/hyprland.lua
```

## Cheat sheet

`SUPER` is the main modifier.

### Apps
| Keys | Action |
|---|---|
| `SUPER+Q` | Terminal (kitty) |
| `SUPER+E` | File manager (dolphin) |
| `SUPER+SPACE` | App launcher (rofi) |
| `SUPER+O` | Lock screen |
| `SUPER+N` | Notification center |
| `SUPER+SHIFT+V` | Clipboard history |
| `SUPER+SHIFT+C` | Color picker (copies hex) |

### Windows
| Keys | Action |
|---|---|
| `SUPER+C` | Close |
| `SUPER+V` | Toggle floating |
| `SUPER+F` / `SUPER+SHIFT+F` | Fullscreen / maximize (keeps bar and gaps) |
| `SUPER+P` | Pseudotile |
| `SUPER+h j k l` | Focus left / down / up / right |
| `SUPER+SHIFT+hjkl` | Move window; past the screen edge it goes to the other monitor |
| `SUPER+CTRL+hjkl` | Swap with the neighbouring window |
| `SUPER+LMB drag` / `SUPER+RMB drag` | Move / resize with the mouse |
| `SUPER+R`, then hjkl | Resize mode: h/l narrower/wider, k/j shorter/taller, hold to repeat. `Esc` or `Enter` exits. |

### Monitors
| Keys | Action |
|---|---|
| `SUPER+,` / `SUPER+.` | Focus previous / next monitor |
| `SUPER+SHIFT+,` / `SUPER+SHIFT+.` | Send window to previous / next monitor |
| `SUPER+X` | Swap workspaces between DP-5 and DP-6 |

### Workspaces
| Keys | Action |
|---|---|
| `SUPER+1…0` | Go to workspace 1–10 (press again to go back) |
| `SUPER+SHIFT+1…0` | Move window there and follow it |
| `SUPER+CTRL+1…0` | Send window there and stay put |
| `SUPER+Tab` | Previous workspace |
| `SUPER+scroll` | Cycle through existing workspaces |
| `SUPER+S` | Toggle scratchpad (Discord + Spotify) |
| `SUPER+SHIFT+S` | Move window to scratchpad |

### Groups (tabs)
| Keys | Action |
|---|---|
| `SUPER+W` | Turn the window into a group, or ungroup it |
| `SUPER+]` / `SUPER+[` | Next / previous tab |
| `SUPER+ALT+hjkl` | Move window into the group in that direction |
| `SUPER+ALT+W` | Pull window out of its group |

### Screenshots
Saved to `~/Pictures/Screenshots`.

| Keys | Action |
|---|---|
| `Print` | Region → clipboard |
| `SHIFT+Print` | Region → file + clipboard |
| `SUPER+Print` | Current monitor → file + clipboard |

### Media
These also work on the lock screen.

| Keys | Action |
|---|---|
| Volume up / down | ±5% (hold to repeat) |
| Mute / Mic mute | Toggle |
| Play, Pause | Play / pause |
| Next / Previous | Skip tracks |
