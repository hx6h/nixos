{ config, pkgs, ... }:

# System composition. Everything system wide that is not big enough to deserve
# its own file in ./modules lives here.
{
  imports = [
    ./hardware-configuration.nix

    ./modules/audio.nix
    ./modules/bluetooth.nix
    ./modules/bootloader.nix
    ./modules/gaming.nix
    ./modules/networking.nix
    ./modules/portals.nix
    ./modules/services.nix
    ./modules/virtualisation.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Prague";

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

  # Packages every user of the system gets. Per-user applications are
  # installed by Home Manager in ./home.nix instead.
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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.amdgpu.initrd.enable = true;

  hardware.enableRedistributableFirmware = true;

  # Give realtime audio clients a lower rtkit scheduling threshold.
  security.rtkit = {
    enable = true;
    args = [ "--no-canary" "--rttime-usec-max=2000000" ];
  };

  systemd.user.units."graphical-session.target".text = ''
    [Unit]
    RefuseManualStart=false
    StopWhenUnneeded=false
  '';

  services.displayManager.ly.enable = true;

  programs.zsh.enable = true;
  programs.hyprland.enable = true;

  system.stateVersion = "26.11";
}
