{ pkgs, ... }:

let
  dots = ./.;

  # Generate MacShell UI sounds during the Nix build.
  macshellSounds =
    pkgs.runCommand "macshell-sounds"
      {
        nativeBuildInputs = [
          (pkgs.python3.withPackages (ps: [ ps.numpy ]))
        ];
      }
      ''
        mkdir -p "$out"

        sed 's|os.path.expanduser("~/.local/share/sounds/macshell")|os.environ["out"]|' \
          "${dots}/hypr-macshell/scripts/macshell-make-sounds.py" \
          > make-sounds.py

        python3 make-sounds.py
      '';
in
{
  home = {
    packages = with pkgs; [
      quickshell
      qt6Packages.qtshadertools
      awww
      mpvpaper
      ffmpeg
      whitesur-icon-theme
      inter
      noto-fonts
      grim
      slurp
      wf-recorder
      libnotify
      wl-clipboard
      cliphist
      hyprpicker
      hyprsunset
      brightnessctl
      inotify-tools
      zenity
      fastfetch
      networkmanagerapplet
    ];
    file.".local/share/sounds/macshell".source = macshellSounds;
    sessionVariables = {
      QS_ICON_THEME = "WhiteSur";
    };
  };

  xdg.configFile = {
    "quickshell/MacShell".source = dots + /quickshell/MacShell;

    "quickshell/MacLock".source = dots + /quickshell/MacLock;

    "hypr".source = dots + /hypr;

    "hypr-macshell".source = dots + /hypr-macshell;
  };
}
