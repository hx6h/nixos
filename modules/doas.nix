{ ... }:

{
  security.sudo.enable = false;

  security.doas = {
    enable = true;

    extraRules = [
      {
        users = [ "femboy" ];
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
