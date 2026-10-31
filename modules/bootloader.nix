{
  boot.loader = {
    limine = {
      enable = true;
      maxGenerations = 2;
      secureBoot.enable = false;
    };
    efi.canTouchEfiVariables = true;
  };
}
