{ config, pkgs, ... }:

# XDG desktop portals: the portal daemon plus the Hyprland, GTK and terminal
# file chooser implementations.
{
  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-termfilechooser
      xdg-desktop-portal-gtk
    ];

    config.common = {
      default = [ "hyprland" "gtk" ];
      "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
    };
  };
}
