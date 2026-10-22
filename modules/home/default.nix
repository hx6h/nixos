{ config, ... }:
{
  imports = [ ./packages.nix ./colors.nix ];

  # Quickshell replaces the old bar, launcher, notification daemon, and wallpaper process.
  xdg.dataFile."wayland-sessions/dwm_qs-monomodern.desktop".text = ''
    [Desktop Entry]
    Name=dwm_qs-monomodern
    Comment=dwl + Quickshell, monochrome and lightweight
    Exec=dwl -s "qs -c dwm_qs-monomodern"
    Type=Application
    DesktopNames=dwm_qs-monomodern
  '';
}
