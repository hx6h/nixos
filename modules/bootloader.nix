{ config, pkgs, ... }:

{
  boot.loader.limine = {
    enable = true;
    maxGenerations = 2;
    extraEntries = ''
      /Windows
        protocol: efi
        path: uuid(5a203caf-515d-445c-862a-a33f85ee2be4):/EFI/Microsoft/Boot/bootmgfw.efi
    '';
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
