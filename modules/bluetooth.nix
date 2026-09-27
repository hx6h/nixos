{ config, pkgs, ... }:

# Bluetooth stack and the Blueman manager.
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    disabledPlugins = [ "handsfree" ];
  };

  services.blueman.enable = true;
}
