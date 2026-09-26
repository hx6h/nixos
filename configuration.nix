{ config, pkgs, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

  time.timeZone = "Europe/Prague";

  nixpkgs.config.allowUnfree = true;

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = "cz-lat2";
  services.xserver.xkb = {
    layout = "cz";
    variant = "";
  };

  users.users.femboy = {
    isNormalUser = true;
    extraGroups = [ "network" "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.zsh;
  };

  environment.systemPackages = with pkgs; [
    git
    curl
    kitty
    yazi
    xdg-desktop-portal-termfilechooser
  ];

  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    GDK_DEBUG = "portals";
    TERMCMD = "kitty --class=file_chooser";
  };

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    noto-fonts-color-emoji
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "Iosevka Nerd Font"
      "Noto Color Emoji"
    ];
  };

  imports = [
    ./hardware-configuration.nix
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.amdgpu.initrd.enable = true;

  hardware.enableRedistributableFirmware = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

  hardware.bluetooth.disabledPlugins = [ "handsfree" ];
  services.blueman.enable = true;

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="4852", ATTR{power/control}="on"
  '';

  security.rtkit = {
    enable = true;
    args = [ "--no-canary" "--rttime-usec-max=2000000" ];
  };

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig.pipewire."92-buffer-size" = {
      "context.properties" = {
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 512;
        "default.clock.max-quantum" = 2048;
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 48000 ];
      };
    };

    wireplumber.extraConfig = {
      "10-bluez" = {
        "monitor.bluez.properties" = {
          "bluez5.enable-sbc-xq" = true;
          "bluez5.enable-msbc" = true;
          "bluez5.enable-hw-volume" = true;

          "bluez5.roles" = [ "a2dp_sink" "a2dp_source" "bap_sink" "bap_source" ];
          "bluez5.auto-connect" = [ "a2dp_sink" "bap_sink" ];

          "bluez5.enable-battery-volume" = false;
        };
      };
      "11-bluetooth-policy" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
      };
    };
  };

  systemd.user.units."graphical-session.target".text = ''
    [Unit]
    RefuseManualStart=false
    StopWhenUnneeded=false
  '';

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-termfilechooser
      xdg-desktop-portal-gtk
    ];
    config = {
      common = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "termfilechooser" ];
      };
    };
  };

  services.displayManager.ly.enable = true;

  programs.zsh.enable = true;
  programs.hyprland.enable = true;

  programs.gamemode.enable = true;
  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.openssh.enable = true;
  services.dbus.enable = true;

  services.flatpak.enable = true;
  systemd.services.flatpak-repo = {
    wantedBy = [ "multi-user.target" ];
    path = [ pkgs.flatpak ];
    script = ''
      flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    '';
  };

  system.stateVersion = "26.11";
}
