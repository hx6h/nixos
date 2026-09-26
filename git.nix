{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "hx6h";
    userEmail = "hx6h@proton.me";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
      url = {
        "git@github.com:" = {
          insteadOf = "https://github.com/";
        };
      };
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
      };
    };
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
    };
  };
}
