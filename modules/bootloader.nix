{ config, pkgs, ... }:

{
  boot.loader.limine = {
    enable = true;
    maxGenerations = 2;
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
