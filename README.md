# hx6h/nixos

Modular NixOS + Home Manager configuration with a low-overhead Wayland desktop.

## Desktop: dwm_qs-monomodern

The profile combines **dwl** with **Quickshell**. Quickshell owns the floating top bar, app launcher, notification panel, control center, and wallpaper layer. The aim is to avoid parallel Waybar, Rofi, Mako, swaybg, and Hyprpaper processes in the active session.

## Shared dotfile themes

Every theme has a palette file at `dots/<theme>/colors.nix`. The active palette is selected once in `modules/home/colors.nix`. Home Manager renders the same semantic color tokens into Quickshell, Kitty, Cava, Fastfetch, Waybar, Rofi, MangoWC, Flameshot, GTK CSS, and the Zsh prompt.

Available palettes:

- `dots/dwm_qs-monomodern/colors.nix`: monochrome, active profile.
- `dots/mango-monochrome/colors.nix`: existing MangoWC palette.
- `dots/catppuccin-mocha/colors.nix`: Catppuccin Mocha palette.

To switch palettes, change the import at the top of `modules/home/colors.nix`. The generated application files then inherit that palette without maintaining separate hex codes.

## Build safely

Changes are on `rewrite/dwm-qs-monomodern`, not `main`. Review the diff and test the build before switching the live system:

```sh
nix flake lock
nix flake check
doas nixos-rebuild build --flake .#nixos
```

Only switch after a successful build, and keep a known-good TTY/login path available while testing a new compositor session.
