{ config, pkgs, ... }:

{
  boot.loader.limine = {
    enable = true;

    extraEntries = ''
      /Windows
        protocol: efi
        path: uuid(5a203caf-515d-445c-862a-a33f85ee2be4):/EFI/Microsoft/Boot/bootmgfw.efi

      /Arch Linux (HDD)
        protocol: efi
        path: uuid(d204b4d4-a2fe-4ea6-b5f2-ac2be617b4b9):/EFI/Linux/arch-linux.efi
    '';

    maxGenerations = 2;
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
