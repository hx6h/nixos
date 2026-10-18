{ pkgs, areofyl-fetch, ... }:

let
  dots = ./dots/mango-monochrome;
in
{

  imports = [ areofyl-fetch.homeManagerModules.default ];

  home.username = "hx6h";
  home.homeDirectory = "/home/hx6h";
  home.stateVersion = "26.11";

  home.packages = with pkgs; [
    # system
    dbus
    ntfs3g
    imagemagick
    btop
    zip
    unzip
    vlc
    proton-vpn
    veracrypt
    playerctl
    appimage-run
    libice
    flameshot
    libelf

    # rice
    waybar
    waybar-mpris
    hyprpaper
    tty-clock
    cmatrix
    cava
    oh-my-zsh
    fastfetch
    rofi
    swaybg
    mako

    # apps
    bluetui
    wiremix
    localsend
    kdePackages.kdenlive
    rofi-screenshot
    brave
    prismlauncher
    obsidian
    telegram-desktop

    # themes
    adw-gtk3
    adwaita-icon-theme
    qt6Packages.qt6ct
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.plasma-integration

    # development
    zed-editor

    opencode
    pycharm
    jetbrains.idea

    jdk25
    maven

    python3

    nodejs_26

    php
  ];

  programs = {
    zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      initContent = "source ~/.zshrc_custom";
    };

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
        obs-gstreamer
        obs-vkcapture
      ];
    };

    fetch = {
      enable = true;
      labelColor = "magenta";
      info = [
        "os"
        "host"
        "kernel"
        "cpu"
        "memory"
        "disk"
        "wm"
        "shell"
        "terminal"
      ];
      speed = 1.0;
      spin = "xy";
    };
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
    # Without this the cursor never reaches GTK, only X11 and the icon path.
    gtk.enable = true;
  };

  # GTK apps follow the same fonts and icons as the Qt side. The Catppuccin icon
  # theme lives in ~/.local/share from KNewStuff, so GTK2 apps are pointed at
  # that name while GTK3 and GTK4 get the packaged themes below.
  gtk = {
    enable = true;

    font = {
      name = "Iosevka Nerd Font";
      size = 10;
    };

    theme = {
      package = pkgs.adw-gtk3;
      name = "adw-gtk3-dark";
    };

    iconTheme = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
    };

    colorScheme = "dark";

    # adw-gtk3 is a GTK3 theme, so GTK2 apps keep the system widget theme but
    # do follow the Catppuccin icons and the legacy tuning the options above
    # have no place for.
    gtk2 = {
      theme = null;
      iconTheme.name = "Catppuccin-Mocha";

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

  home.file.".zshrc_custom".source = dots + /zsh/zshrc;
  home.file.".oh-my-zsh/themes/hx6h.zsh-theme".source = dots + /zsh/themes/hx6h.zsh-theme;

  # Application configuration, deployed to ~/.config/<app>.
  xdg.configFile = {
    "cava".source = dots + /cava;
    "fastfetch".source = dots + /fastfetch;
    "mango".source = dots + /mango;
    "kitty".source = dots + /kitty;
    "waybar".source = dots + /waybar;
    "rofi".source = dots + /rofi;
    "images".source = dots + /images;
  };
}
