{ pkgs, lib, ... }:

let
  fileChooserPath = lib.makeBinPath [
    pkgs.bash
    pkgs.coreutils
    pkgs.gnused
    pkgs.kitty
    pkgs.yazi
  ];
in
{
  hardware = {
    graphics.enable = true;
    amdgpu.initrd.enable = true;
    enableRedistributableFirmware = true;
  };

  environment = {
    systemPackages = with pkgs; [
      mesa
      libva
      libva-utils
      mesa-demos
      kitty
      yazi
      slurp
    ];

    sessionVariables = {
      GTK_USE_PORTAL = "1";
    };

    etc."xdg/xdg-desktop-portal-termfilechooser/config".text = ''
      [filechooser]
      cmd = ${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      env=PATH=${fileChooserPath}:/run/current-system/sw/bin
      env=TERMCMD=kitty
      default_dir=$HOME
      open_mode=suggested
      save_mode=last
    '';
  };

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
      xdg-desktop-portal-termfilechooser
    ];

    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };

      mango = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      };
    };

    wlr = {
      enable = true;

      settings.screencast = {
        chooser_type = "simple";
        chooser_cmd = "${pkgs.slurp}/bin/slurp -f 'Monitor: %o' -or";
        max_fps = 30;
        output_width = 1280;
        output_height = 720;
        video_bitrate = 4000;
      };
    };
  };
}
