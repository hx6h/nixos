# you must add this to configuration.nix btw
{ pkgs, ... }:

{
  security = {
    pam.services.hyprlock = { };
    polkit.enable = true;
  };

  programs.hyprlock.enable = true;

  environment.systemPackages = with pkgs; [
    hyprlock
    hypridle
  ];

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;
    gvfs.enable = true;
  };
}
