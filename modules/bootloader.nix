{
  boot.loader = {
    limine = {
      enable = true;
      maxGenerations = 10;
      secureBoot.enable = false;
    };
    efi.canTouchEfiVariables = true;
  };
}
