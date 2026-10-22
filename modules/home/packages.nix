{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Core tools already used in the active dotfiles.
    kitty yazi git curl btop playerctl imagemagick ntfs3g zip unzip
    cava fastfetch oh-my-zsh

    # One compositor + one shell. No Waybar/Rofi/Mako/swaybg/Hyprpaper.
    dwl quickshell
    xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
    wl-clipboard grim slurp brightnessctl libnotify

    # Existing apps and development tools remain installed.
    bluetui wiremix localsend kdePackages.kdenlive flameshot librewolf
    prismlauncher obsidian telegram-desktop zed-editor opencode pycharm
    jetbrains.idea jdk25 maven python314 python314Packages.pip nodejs_26 php

    # Existing theme, cursor and font stack.
    adw-gtk3 adwaita-icon-theme qt6Packages.qt6ct
    bibata-cursors nerd-fonts.iosevka noto-fonts-color-emoji
  ];
}
