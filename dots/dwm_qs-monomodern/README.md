# dwm_qs-monomodern dotfiles

This is the active dot profile for the `dwm_qs-monomodern` desktop.
The palette in `colors.nix` is the single source of truth for generated
Quickshell, Kitty, Waybar, Rofi, Cava, Mango, GTK, Flameshot, Fastfetch and
Zsh theme files.

Templates use `@TOKEN@` placeholders. Home Manager renders them from the
palette, so applications do not drift into separate, hard-coded themes.
The profile intentionally uses dwl + Quickshell instead of running a second
bar, launcher, wallpaper daemon or notification daemon.
