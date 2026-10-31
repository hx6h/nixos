
{ pkgs, ... }:

let
  dots = ./.;

  # Generate MacShell UI sounds during the Nix build.
  macshellSounds = pkgs.runCommand "macshell-sounds" {
    nativeBuildInputs = [
      (pkgs.python3.withPackages (ps: [ ps.numpy ]))
    ];
  } ''
    mkdir -p "$out"

    sed 's|os.path.expanduser("~/.local/share/sounds/macshell")|os.environ["out"]|' \
      "${dots}/hypr-macshell/scripts/macshell-make-sounds.py" \
      > make-sounds.py

    python3 make-sounds.py
  '';
in
{
  home.packages = with pkgs; [
    # Quickshell
    quickshell
    qt6Packages.qtshadertools

    # Wallpapers
    awww
    mpvpaper
    ffmpeg

    # Icons
    whitesur-icon-theme

    # Fonts
    inter
    noto-fonts

    # Screenshots and recording
    grim
    slurp
    wf-recorder
    libnotify

    # Clipboard
    wl-clipboard
    cliphist

    # Desktop utilities
    hyprpicker
    hyprsunset
    brightnessctl
    inotify-tools
    zenity
    fastfetch
    networkmanagerapplet
  ];

  home.file.".local/share/sounds/macshell".source = macshellSounds;

  home.sessionVariables = {
    QS_ICON_THEME = "WhiteSur";
  };

  xdg.configFile = {
    "quickshell/MacShell".source =
      dots + /quickshell/MacShell;

    "quickshell/MacLock".source =
      dots + /quickshell/MacLock;

    "hypr".source =
      dots + /hypr;

    "hypr-macshell".source =
      dots + /hypr-macshell;
  };
}
