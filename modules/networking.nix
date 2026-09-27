{ config, pkgs, ... }:

# Host identity, NetworkManager and wireless.
{
  networking.hostName = "nixos";

  networking.networkmanager.enable = true;
  networking.wireless.enable = true;

  # Keep the USB ethernet adapter (0bda:4852) from going into suspend.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="4852", ATTR{power/control}="on"
  '';
}
