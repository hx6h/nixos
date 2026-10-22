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
    gtk2 = {
      theme = null;
      iconTheme.name = "Adwaita";
      extraConfig = ''
        gtk-toolbar-style=3
        gtk-menu-images=1
        gtk-button-images=1
        gtk-cursor-blink=1
        gtk-cursor-blink-time=1000
        gtk-sound-theme-name="ocean"
      '';
    };
    gtk3.extraConfig = {
      gtk-primary-button-warps-slider = true;
      gtk-overlay-scrolling = true;
      gtk-xft-antialias = 1;
      gtk-xft-hinting = 1;
      gtk-xft-hintstyle = "hintslight";
      gtk-xft-rgba = "none";
    };
  };

  programs.fetch = {
    enable = true;
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

  # Keep the currently used wallpapers while giving the new profile ownership
  # of its shell, terminal settings, and shell initialization.
  home.file.".zshrc_custom".source = ./dots/dwm_qs-monomodern/zsh/zshrc;

  xdg.configFile = {
    "kitty/kitty.conf".source = ./dots/dwm_qs-monomodern/kitty/kitty.conf;
    "images".source = ./dots/mango-monochrome/images;
    "quickshell/dwm_qs-monomodern/shell.qml".source = ./desktops/dwm_qs-monomodern/shell.qml;
    "quickshell/dwm_qs-monomodern/MonoButton.qml".source = ./desktops/dwm_qs-monomodern/MonoButton.qml;
  };

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    GTK_THEME = "adw-gtk3-dark";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
    XDG_CURRENT_DESKTOP = "dwm_qs-monomodern";
    XDG_SESSION_TYPE = "wayland";
  };
}
