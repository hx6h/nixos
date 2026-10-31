{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    disabledPlugins = [ "handsfree" ];
  };

  services.blueman.enable = true;
}
