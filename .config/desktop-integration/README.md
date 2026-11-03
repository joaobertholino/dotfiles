# Gentoo desktop integration

The desktop uses a black background with Gentoo violet accents (#9580bf / #b7a1e5).
Native Gentoo applications use system Mesa and Qt plugins. Nix applications are
launched through `/usr/local/bin/nix-desktop-run`; `/usr/local/bin` must precede
`/opt/hyprland/bin` in PATH. Reference copies of the system launchers are in
`system-launchers/`. Installing those copies requires root privileges.

## Shortcuts

- Super+V: search clipboard history; Enter copies the selected entry, then Ctrl+V pastes it.
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

## Packages

hyprsunset 0.4.0, cliphist 0.7.0 and fuzzel 1.15.0 are pinned through Nix GC roots
under /opt/desktop-tools. Kvantum 1.1.8 is installed natively through Portage.
The Font Awesome 7.2.0 Solid font was copied to ~/.local/share/fonts/waybar-icons.

Session services are tied to hyprland-session.target. Existing applications
may need reopening to receive the new theme and library environment.
