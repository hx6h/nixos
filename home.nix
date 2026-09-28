{ pkgs, ... }:

let
  dots = ./dots;
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
    localsend
    kdePackages.kdenlive

    # themes
    adw-gtk3
    adwaita-icon-theme
    qt6Packages.qt6ct
    kdePackages.breeze
    kdePackages.breeze-icons
    kdePackages.plasma-integration

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
    opencode-desktop
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

  home.file.".zshrc_custom".source = dots + /zsh/zshrc;
  home.file.".oh-my-zsh/themes/hx6h.zsh-theme".source = dots + /zsh/themes/hx6h.zsh-theme;

  # Application configuration, deployed to ~/.config/<app>.
  xdg.configFile = {
    "cava".source = dots + /cava;
    "fastfetch".source = dots + /fastfetch;
    "flameshot".source = dots + /flameshot;
    "hypr".source = dots + /hypr;
    "kitty".source = dots + /kitty;
    "rofi".source = dots + /rofi;
    "waybar".source = dots + /waybar;
    "images".source = dots + /images;
  };
}
