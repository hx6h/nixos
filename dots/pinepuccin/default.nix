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
    adw-gtk3
    adwaita-icon-theme
    qt6Packages.qt6ct
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.plasma-integration
  ];
  file.".zshrc_custom".source = dots + /zsh/zshrc;

  xdg.configFile = {
    "cava".source = dots + /cava;
    "fastfetch".source = dots + /fastfetch;
    "images".source = dots + /images;
    "kitty".source = dots + /kitty;
    "mango".source = dots + /mango;
    "rofi".source = dots + /rofi;
    "waybar".source = dots + /waybar;
  };
}
