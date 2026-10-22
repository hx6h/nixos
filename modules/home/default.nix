{ config, ... }:
{
  imports = [ ./packages.nix ./colors.nix ];

  # Ly discovers this session. Quickshell owns the entire visual shell.
  xdg.dataFile."wayland-sessions/dwm_qs-monomodern.desktop".text = ''
    [Desktop Entry]
    Name=dwm_qs-monomodern
    Comment=dwl + Quickshell, monochrome and lightweight
    Exec=dwl -s "sh -c 'quickshell -p ${config.home.homeDirectory}/.config/quickshell/dwm_qs-monomodern/shell.qml & wait'"
    Type=Application
    DesktopNames=dwm_qs-monomodern
  '';
}
