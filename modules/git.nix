{
  programs = {
    git = {
      enable = true;
      settings = {
        user = {
          name = "hx6h";
          email = "hx6h@proton.me";
        };
        init.defaultBranch = "main";
        pull.rebase = false;
        url."git@github.com:".insteadOf = "https://github.com/";
      };
    };
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "github.com" = {
          HostName = "github.com";
          IdentityFile = "~/.ssh/id_ed25519";
          User = "git";
        };
        "*" = {
          AddKeysToAgent = "no";
          Compression = false;
          ControlMaster = "no";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "no";
          ForwardAgent = false;
          HashKnownHosts = false;
          ServerAliveCountMax = 3;
          ServerAliveInterval = 0;
          UserKnownHostsFile = "~/.ssh/known_hosts";
        };
      };
    };
    gh = {
      enable = true;
      settings.git_protocol = "ssh";
    };
  };
}
