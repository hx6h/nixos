{ ... }:

{
  security.sudo.enable = false;

  security.doas = {
    enable = true;

    extraRules = [
      {
        users = [ "hx6h" ];
        keepEnv = true;
        persist = true;
      }
    ];
  };

  environment.etc."gitconfig".text = ''
      [safe]
          directory = /etc/nixos
    '';
}
