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
    librewolf

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
    "flameshot".source = dots + /flameshot;
    "hypr".source = dots + /hypr;
    "kitty".source = dots + /kitty;
    "rofi".source = dots + /rofi;
    "waybar".source = dots + /waybar;
    "images".source = dots + /images;
  };
}
