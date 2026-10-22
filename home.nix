{ pkgs, areofyl-fetch, ... }:
{
  imports = [ areofyl-fetch.homeManagerModules.default ./modules/home ];
  home.username = "larp";
  home.homeDirectory = "/home/larp";
  home.stateVersion = "26.11";

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initContent = "source ~/.zshrc_custom";
  };
  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    gtk.enable = true;
  };
  gtk = {
    enable = true;
    font = { name = "Iosevka Nerd Font"; size = 10; };
    theme = { package = pkgs.adw-gtk3; name = "adw-gtk3-dark"; };
    iconTheme = { package = pkgs.adwaita-icon-theme; name = "Adwaita"; };
    colorScheme = "dark";
  };
  programs.fetch = {
    enable = true;
    labelColor = "white";
    info = [ "os" "host" "kernel" "cpu" "memory" "disk" "wm" "shell" "terminal" ];
    speed = 1.0;
    spin = "xy";
  };
  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs obs-backgroundremoval obs-pipewire-audio-capture
      obs-vaapi obs-gstreamer obs-vkcapture
    ];
  };

  home.file.".zshrc_custom".source = ./dots/mango-monochrome/zsh/zshrc;
  home.file.".oh-my-zsh/themes/hx6h.zsh-theme".source = ./dots/mango-monochrome/zsh/themes/hx6h.zsh-theme;
  xdg.configFile = {
    "cava".source = ./dots/mango-monochrome/cava;
    "fastfetch".source = ./dots/mango-monochrome/fastfetch;
    "kitty/kitty.conf".source = ./dots/mango-monochrome/kitty/kitty.conf;
    "images".source = ./dots/mango-monochrome/images;
    "quickshell/dwm_qs-monomodern/shell.qml".source = ./desktops/dwm_qs-monomodern/shell.qml;
  };
  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    XDG_CURRENT_DESKTOP = "dwm_qs-monomodern";
  };
}
