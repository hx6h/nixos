{ ... }:
{
  imports = [ ./packages.nix ./colors.nix ];

  # Ly discovers this session. dwl starts Quickshell as its status/startup process.
  xdg.dataFile."wayland-sessions/dwm_qs-monomodern.desktop".text = ''
    [Desktop Entry]
    Name=dwm_qs-monomodern
    Comment=dwl + Quickshell, monochrome and lightweight
    Exec=dwl -s "sh -c 'quickshell -p /home/larp/.config/quickshell/dwm_qs-monomodern/shell.qml & cat >/dev/null'"
    Type=Application
    DesktopNames=dwm_qs-monomodern
  '';
}
