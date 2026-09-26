{ pkgs, ... }:

let
  mod = ./modules;
in
{
  home.username = "femboy";
  home.homeDirectory = "/home/femboy";
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

    # rice
    waybar
    waybar-mpris
    waybar-lyric
    hyprpaper
    tty-clock
    cmatrix
    cava
    oh-my-zsh

    # apps
    kitty
    rofi
    bluetui
    wiremix

    # development
    opencode
    github-desktop
    jdk25
    maven
    python3
    zed-editor
    fastfetch
    flameshot
    prismlauncher
  ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = "source ~/.zshrc_custom";
  };

  programs.obs-studio = {
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

  programs.firefox = {
    enable = true;

    languagePacks = [ "en-US" ];

    policies = {
      DisableTelemetry = true;

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/addon-607454-latest.xpi";
        };
        "{7a7a4a92-a2a0-41d1-9ba4-62e295fc356d}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/styl-us/addon-1458055-latest.xpi";
        };
      };
    };
  };

  home.pointerCursor = {
    enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 24;
  };

  gtk.enable = true;

  home.file.".zshrc_custom".source = mod + /zshrc;
  home.file.".oh-my-zsh/themes/hx6h.zsh-theme".source = mod + /oh-my-zsh/themes/hx6h.zsh-theme;

  xdg.configFile = {
    "cava".source = mod + /configs/cava;
    "fastfetch".source = mod + /configs/fastfetch;
    "flameshot".source = mod + /configs/flameshot;
    "hypr".source = mod + /configs/hypr;
    "kitty".source = mod + /configs/kitty;
    "rofi".source = mod + /configs/rofi;
    "waybar".source = mod + /configs/waybar;
    "images".source = mod + /configs/images;
  };
}
