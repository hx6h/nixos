{ config, pkgs, ... }:

# limine, with permission to manage the EFI variables itself.
{
  boot.loader.limine = {
    enable = true;
    extraEntries = ''
            /Windows
              protocol: efi
              path: uuid(1c135138-506a-45ed-8352-6455f45e9fea):/EFI/Microsoft/Boot/bootmgfw.efi
          '';
    maxGenerations = 5;
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
