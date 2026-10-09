{

  description = "NixOS Flake Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # LazyVim as a Home Manager module, plugins and treesitter parsers included.
    lazyvim = {
      url = "github:pfassina/lazyvim-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    areofyl-fetch.url = "github:areofyl/fetch";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      lazyvim,
      areofyl-fetch,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            self
            nixpkgs
            home-manager
            lazyvim
            areofyl-fetch
            ;
        };

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";
            home-manager.extraSpecialArgs = { inherit lazyvim areofyl-fetch; };
            home-manager.users.femboy = {
              imports = [
                ./home.nix
                ./modules/git.nix
                ./modules/nvim.nix
              ];
            };
          }
        ];
      };
    };
}
