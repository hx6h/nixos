{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # System and everyday tools retained from the existing setup.
    dbus ntfs3g imagemagick btop zip unzip vlc proton-vpn veracrypt
    playerctl appimage-run libice flameshot libelf

    # Terminal and shell utilities already referenced by the dotfiles.
    kitty yazi git curl cava oh-my-zsh fastfetch tty-clock cmatrix

    # One active compositor and one desktop shell.
    dwl quickshell

    # Existing applications.
    bluetui wiremix localsend kdePackages.kdenlive librewolf
    prismlauncher obsidian telegram-desktop

    # Existing theme, cursor, and font stack.
    adw-gtk3 adwaita-icon-theme qt6Packages.qt6ct
    kdePackages.breeze kdePackages.breeze-icons kdePackages.plasma-integration
    bibata-cursors nerd-fonts.iosevka noto-fonts-color-emoji

    # Existing development tools.
    zed-editor opencode pycharm jetbrains.idea
    jdk25 maven python314 python314Packages.pip nodejs_26 php
  ];
}
