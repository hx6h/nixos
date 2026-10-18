{ config, pkgs, ... }:

# System wide gaming: gamemode and Steam.
{
  programs.gamemode.enable = true;

  programs.steam = {
    enable = true;
    dedicatedServer.openFirewall = true;
    remotePlay.openFirewall = true;
  };
}
