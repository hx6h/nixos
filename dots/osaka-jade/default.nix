{ pkgs, ... }:

let
  dots = ./.;
in
{
  home.packages = with pkgs; [
    waybar
    waybar-mpris
    tty-clock
    cmatrix
    cava
    fastfetch
    rofi
    swaybg
    mango
    mako
    walker
    elephant
    adw-gtk3
    adwaita-icon-theme
    qt6Packages.qt6ct
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.plasma-integration
  ];

  home.file = {
    ".zshrc_custom".source = dots + /zsh/zshrc;
    ".oh-my-zsh/themes/hx6h.zsh-theme".source = dots + /zsh/themes/hx6h.zsh-theme;
  };

  xdg.configFile = {
    "cava".source = dots + /cava;
    "fastfetch".source = dots + /fastfetch;
    "images".source = dots + /images;
    "kitty".source = dots + /kitty;
    "mango".source = dots + /mango;
    "walker".source = dots + /walker;
    "waybar".source = dots + /waybar;
  };
}
