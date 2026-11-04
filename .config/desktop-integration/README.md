# Gentoo desktop integration

The desktop uses a black background with Gentoo violet accents (#9580bf / #b7a1e5).
The desktop uses Gentoo packages, system Mesa and Qt plugins. The package set
`/etc/portage/sets/native-desktop` includes Hyprland and the desktop applications.
Sway remains installed as an alternative session with its own world selection.
Install or update the native desktop set with
`sudo emerge --ask --update --newuse @native-desktop`.

Hyprland 0.56.2 keeps compatibility with the current Lua configuration. Its
version is selected in the package set and newer incompatible versions are
masked until the configuration has been checked with them. Glaze 8 and newer
are also masked because Hyprland 0.56.2 requires its older header API. Aquamarine 0.16.0
has a local Portage patch to respect the parent compositor’s advertised
xdg-shell version when testing Hyprland inside Sway. Reference copies
of the system launchers are in `system-launchers/`. Installing them requires
root privileges. Avoid adding Nix library paths to the desktop environment.

The Wacom pen maps to HDMI-A-1 with the same transform as the monitor.
Super+Alt+O switches both between portrait and landscape and saves their
orientation in the Hyprland modules. The device transform takes precedence
over the udev calibration matrix.

## Shortcuts

- Super+V: search clipboard history; Enter copies and pastes into the previously focused application.
  Terminals receive Ctrl+Shift+V; other applications receive Ctrl+V.
  If focus changes, the item is copied without automatic paste.
  Run `clipboard-history --copy-only` to select an item without pasting.
- Super+Shift+V: clear clipboard and its history.
- Super+Ctrl+N: temporarily toggle the night-light service.

Night light runs through `hyprsunset.service`: 4500 K from 00:00 to 07:00,
identity during the rest of the day. The toggle lasts until another toggle or
session restart. It does not modify the monitor brightness.

Clipboard history runs through `clipboard-history.service` and stores at most
200 entries of up to 2 MiB each. It ignores selections marked sensitive or
advertising password MIME types. Applications that do not mark secrets cannot
be detected reliably. Data stays in ~/.cache/cliphist (private permissions),
outside Git. Only the regular clipboard is monitored, not primary selection.

Waybar uses Font Awesome 7 Free Solid glyphs, not image files. The clock has
no icon and CPU temperature is hidden. The activity module shows Portage
progress, actual OBS recording, microphone capture and failed system/user units.
Click its indicator to inspect failed units and recent user errors.
Microphone capture from monitor sources is excluded; the separate mic button
continues to toggle mute. OBS status comes from the log currently opened by
OBS and is cleared when the process exits. Checks run every three seconds.

The Hyprlock PAM policy in `/etc/pam.d/hyprlock` remains the existing
password-based policy, without an authentication-failure lockout.

## Packages

Hyprsunset, cliphist, fuzzel and Kvantum are managed by Portage. PipeWire,
WirePlumber and the desktop portals use the service units shipped by their
Gentoo packages. Hyprland and Sway have separate portal preferences in
`~/.config/xdg-desktop-portal/`. GtkHash and the Thunar Dropbox plugin use the
local-desktop repository because the enabled repositories lack those packages.
The `smbd-thunar.service` sharing service uses native Samba and preserves
the existing `/etc/samba/smb.conf` and usershare data.
Lean 4.35.0 uses its official upstream Linux distribution, installed and owned
by Portage through the same local repository, to preserve the existing toolchain
version without depending on Nix.
The Font Awesome 7.2.0 Solid font was copied to ~/.local/share/fonts/waybar-icons.

Session services are tied to hyprland-session.target. Existing applications
may need reopening to receive the new theme and library environment.
