# Dotfile themes

Each selectable theme owns a `colors.nix` palette. Home Manager reads the selected palette and renders shared templates into the real application config paths.

- `dwm_qs-monomodern`: active profile, dwl + Quickshell, monochrome.
- `mango-monochrome`: existing MangoWC setup, same palette schema.
- `catppuccin-mocha`: existing Catppuccin setup, same palette schema.

The palette schema stays consistent across themes. To switch palettes, change the import in `modules/home/colors.nix`. Templates use semantic tokens such as `@BACKGROUND@`, `@FOREGROUND@`, `@ACCENT@`, and `@ANSI0@`, not per-app hard-coded colors.
