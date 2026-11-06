# Niri on Gentoo

An independent Niri session alongside Hyprland and Sway. Select **Niri** in Ly when logging in. The configuration does not start Niri inside Hyprland or modify Hyprland settings.

## Native packages

Portage set `/etc/portage/sets/niri-desktop` includes Niri, xwayland-satellite, Waybar with its `niri` USE flag, wlsunset and the GNOME desktop portal. Installation and updates use `sudo emerge --ask --update --newuse @niri-desktop`. Portage settings are maintained separately from this repository.

## Configuration

`config.kdl` includes input/output settings, appearance, application environment, key bindings and window rules. Saved settings reload automatically. `scripts/reload-config` validates the configuration and reloads the Niri Waybar.

The HDMI-A-1 output uses **1920×1080 at 120 Hz**, scale 1, initially rotated 90° for portrait use. Super+Alt+O toggles landscape/portrait and saves the choice in `input-output.kdl`. The tablet maps to this output. Niri applies the output rotation to tablet coordinates automatically; the identity calibration matrix overrides the system-wide portrait calibration to avoid applying the rotation twice.

Waybar uses its own configuration and stylesheet here, with Niri workspaces and the existing system metrics. Workspaces are dynamic: Niri creates an empty workspace after the occupied ones. Application windows use Niri's scrolling columns; utilities such as Qalculate float and open centered.

The launcher, borders and bar use the existing Gentoo purple palette. The wallpaper helper reads the selected image from Waypaper and runs a separate awww daemon namespace. The lock screen copies the existing Hyprlock appearance and uses the already installed PAM configuration.

## Main shortcuts

| Shortcut | Action |
| --- | --- |
| Super+Enter | Terminal |
| Super+Space | Application launcher |
| Super+Alt+B / E / C / X | Firefox / Emacs / Qalculate / Xournal++ |
| Super+H / L | Focus previous/next column |
| Super+J / K | Focus window below/above |
| Super+Shift+H / L / J / K | Move column/window |
| Super+1…9, 0 | Focus workspace 1…10, if it exists |
| Super+Shift+1…9, 0 | Move window to workspace |
| Super+Tab | Previous workspace |
| Super+O | Overview |
| Super+R | Cycle column widths |
| Super+M / F | Maximize column / fullscreen |
| Super+T | Toggle floating |
| Super+Comma / Period | Add window to column / separate window |
| Super+W | Close window |
| Super+Alt+O | Rotate output and tablet together |
| Super+V / Super+Shift+V | Clipboard history / clear history |
| Super+Ctrl+N | Toggle scheduled night light |
| Super+Ctrl+L | Lock screen |
| Super+Ctrl+Escape | Power menu |
| Super+Alt+Q | Log out with confirmation |
| Super+Escape / Super+Alt+R | Validate configuration and reload bar |
| Print / Shift+Print / Super+Print | Select area / capture window / capture screen |

Math-symbol shortcuts and media keys are listed in `bindings.kdl`.

## Session services

The vendor `niri-session` starts `niri.service`. Separate user services start the Niri Waybar, Dunst, wallpaper, clipboard watcher and scheduled night light; they stop with the Niri session. Lock and calendar services run only on demand. NetworkManager's tray application and the GNOME polkit agent use their installed XDG autostart entries, avoiding duplicate agents. The existing Hyprland services are unchanged.

Night light uses 4500 K from **00:00 to 07:00**, restoring the normal display outside this interval. `niri-portals.conf` selects the GNOME screen-sharing portal and GTK file chooser specifically for Niri. XWayland applications run through xwayland-satellite.

Useful checks:

```sh
niri validate
niri msg outputs
systemctl --user status niri.service niri-waybar.service
journalctl --user -b -u niri.service
```

To return to Hyprland or Sway, log out and select that session in Ly.
