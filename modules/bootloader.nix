{ config, pkgs, ... }:

# systemd-boot, with permission to manage the EFI variables itself.
{
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
