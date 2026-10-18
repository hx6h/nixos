
{ pkgs, lib, ... }:

let
  fileChooserPath = lib.makeBinPath (with pkgs; [
    bash
    coreutils
    gnused
    kitty
    yazi
  ]);
in
{
  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-termfilechooser
    ];

    # Screen sharing for MangoWC
    wlr = {
      enable = true;

      settings = {
        screencast = {
          chooser_type = "simple";
          chooser_cmd =
            "${pkgs.slurp}/bin/slurp -f 'Monitor: %o' -or";
          max_fps = 30;
        };
      };
    };

    # Portal backend selection
    config = {
      common = {
        default = [ "gtk" ];

        "org.freedesktop.impl.portal.FileChooser" = [
          "termfilechooser"
        ];

        "org.freedesktop.impl.portal.ScreenCast" = [
          "wlr"
        ];

        "org.freedesktop.impl.portal.Screenshot" = [
          "wlr"
        ];
      };

      # MangoWC uses the lowercase desktop name
      mango = {
        default = [ "gtk" ];

        "org.freedesktop.impl.portal.FileChooser" = [
          "termfilechooser"
        ];

        "org.freedesktop.impl.portal.ScreenCast" = [
          "wlr"
        ];

        "org.freedesktop.impl.portal.Screenshot" = [
          "wlr"
        ];
      };
    };
  };

  # Ensure the chooser and its terminal are available
  environment.systemPackages = with pkgs; [
    kitty
    slurp
    yazi
  ];

  # Use portals for GTK file dialogs too
  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
  };

  # Yazi configuration for termfilechooser
  environment.etc."xdg/xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd = ${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    env=PATH=${fileChooserPath}:/run/current-system/sw/bin
    env=TERMCMD=kitty
    default_dir=$HOME
    open_mode=suggested
    save_mode=last
  '';
}
