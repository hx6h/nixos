# dwm_qs-monomodern

A low-overhead desktop profile built from:

- **dwl** for the Wayland compositor.
- **Quickshell** for the floating top bar, application launcher, notifications,
  control center, and wallpaper layer.
- **One shared palette**, imported from `dots/dwm_qs-monomodern/colors.nix`.

The active shell deliberately avoids launching parallel bars, launchers,
notification daemons, or wallpaper daemons. Other dot profiles are retained
as palettes/templates and can be selected without copying hex values into QML.
