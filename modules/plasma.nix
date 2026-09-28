{ config, pkgs, ... }:

let
  dots = ../dots;
in

# Plasma desktop configuration: the Catppuccin Mocha theme, panel layout,
# window manager behaviour and global shortcuts kept in ../dots/plasma and
# deployed to ~/.config. Plasma itself is enabled system wide in
# ./services.nix, and ly stays the greeter.
#
# These become read-only symlinks into the nix store, so whatever Plasma writes
# back at session exit is discarded. Edit the files in ../dots/plasma instead of
# going through System Settings.
{
  xdg.configFile = {
    "kcminputrc".source = dots + /plasma/kcminputrc;
    "kdeglobals".source = dots + /plasma/kdeglobals;
    "kglobalshortcutsrc".source = dots + /plasma/kglobalshortcutsrc;
    "kwinrc".source = dots + /plasma/kwinrc;
    "kscreenlockerrc".source = dots + /plasma/kscreenlockerrc;
    "ksplashrc".source = dots + /plasma/ksplashrc;
    "plasmarc".source = dots + /plasma/plasmarc;
    "plasmashellrc".source = dots + /plasma/plasmashellrc;
    "powerdevilrc".source = dots + /plasma/powerdevilrc;
    "spectaclerc".source = dots + /plasma/spectaclerc;
    "plasma-org.kde.plasma.desktop-appletsrc".source =
      dots + /plasma/plasma-org.kde.plasma.desktop-appletsrc;
  };
}
