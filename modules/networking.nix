{
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    wireless.enable = true;
  };

  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0bda", ATTR{idProduct}=="4852", ATTR{power/control}="on"
  '';
}
