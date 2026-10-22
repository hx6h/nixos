{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Core tools already used by the current dotfiles.
    kitty yazi git curl btop playerctl imagemagick ntfs3g zip unzip
    cava fastfetch oh-my-zsh

    # Single compositor + single desktop shell. No parallel bar or launcher.
    dwl quickshell
    xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
    wl-clipboard grim slurp brightnessctl libnotify

    # Existing applications and development stack.
    bluetui wiremix localsend kdePackages.kdenlive flameshot librewolf
    prismlauncher obsidian telegram-desktop zed-editor opencode pycharm
    jetbrains.idea jdk25 maven python314 python314Packages.pip nodejs_26 php

    # Existing GTK/Qt theme and font setup.
    adw-gtk3 adwaita-icon-theme qt6Packages.qt6ct
    bibata-cursors nerd-fonts.iosevka noto-fonts-color-emoji
  ];
}
