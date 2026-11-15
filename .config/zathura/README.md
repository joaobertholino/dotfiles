# Pen navigation

The barrel button reported as Linux BTN_STYLUS / middle button
initiates panning in Zathura. Hold it while moving the pen; hovering and
movement with the tip touching the tablet are both handled. BTN_STYLUS2
retains its right-click role. Tip-only gestures retain text selection.

A GTK capture-phase event controller handles pen events before the normal
click/text-selection gestures. It is independent of X11/Wayland and restricted
to pen tools. The ordinary mouse, eraser tool and other applications are not
remapped. The previous Hyprland/XInput focus remapper was removed.

The local Portage patch is:
`/etc/portage/patches/app-text/zathura-2026.10.23/010-tablet-barrel-pan.patch`.
Portage rebuilt `app-text/zathura-2026.10.23::local-zathura`. New processes use
this build; already running Zathura processes must be reopened by the user.
The version-specific patch needs reviewing if Zathura is upgraded.

Validation: the actual panning state handler was compiled into a GTK test using
real scroll adjustments. Hover, combined tip/barrel input, button release,
proximity-out and right-button preservation passed with both GDK Wayland and
X11. These tests do not replace a physical pen test by the user.

## GTK Wayland event loss (2026-11-15)

A physical pen trace on GTK 4.20.4 showed motion events without the barrel
button state and button releases without matching presses. The GTK Wayland
frame loop incorrectly reads the list head on every iteration, duplicating
one event and discarding other events from the same frame.

The official fix is applied to the installed version through:
`/etc/portage/patches/gui-libs/gtk-4.20.4-r1/020-wayland-tablet-event-iterator.patch`

Upstream commit:
https://github.com/GNOME/gtk/commit/dc0c135f255ce0f6618e4cf8548819de0e439474

It changes `events->data` to `l->data` in
`gdk_wayland_tablet_flush_frame_events`. Existing GTK processes keep their
loaded library until closed and reopened. Remove/review the version-specific
patch when GTK is upgraded to a version that already contains the fix.

GTK 4.20.4-r1 rebuilt and installed successfully on 2026-11-15.
The same capture controller was tested using a native Wayland GTK window
with numbered content. The user confirmed correct dragging both hovering
and with the tip touching the tablet. The physical event trace now includes
middle presses/releases and motion with BUTTON2 and BUTTON1|BUTTON2;
scroll adjustments changed correctly in both cases.
The existing Zathura process was left open and still holds the old library;
it must be closed and reopened to load the fix.
