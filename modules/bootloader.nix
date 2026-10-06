{ config, pkgs, ... }:

{
  boot.loader.limine = {
    enable = true;

    extraEntries = ''
      /Windows
        protocol: efi
        path: uuid(2CCD-E100):/EFI/Microsoft/Boot/bootmgfw.efi

      /Arch Linux (HDD)
        protocol: efi
        path: uuid(9CCD-DA83):/EFI/Linux/archlinux-linux.efi
    '';

    maxGenerations = 2;
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
