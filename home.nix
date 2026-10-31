{ pkgs, areofyl-fetch, ... }:

let
  # ────────────────────────────────────────────────────────────────
  #   catppuccin-mocha - speaks for itself
  #   macos - trying to port https://github.com/0-ss/MacShell (doesnt work)
  #   monochrome - speaks for itself ig
  #   osaka-jade - green (i stole it from omarchy)
  #   pinepuccin - smth between catppuccin and pine lol
  #   rosepine - speaks for iteslf
  # ────────────────────────────────────────────────────────────────
  setup = "osaka-jade";
in
{
  imports = [
    areofyl-fetch.homeManagerModules.default

    (./dots + "/${setup}")
  ];

  home = {
    username = "larp";
    homeDirectory = "/home/larp";
    stateVersion = "26.11";
  };

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
    playerctl
    flameshot
    libelf

    # apps
    bluetui
    wiremix
    librewolf
    prismlauncher
    obsidian
    telegram-desktop

    # development
    zed-editor
    jetbrains.idea

    opencode
    antigravity-ide-fhs
    devin-cli

    jdk25
    maven

    python314
    python314Packages.pip

    nodejs_26

    php

    # shared shell
    oh-my-zsh
  ];

  home.pointerCursor = {
    enable = true;
    package = pkgs.apple-cursor;
    name = "macOS";
    size = 24;
    gtk.enable = true;
  };

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
}
