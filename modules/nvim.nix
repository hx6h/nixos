{ pkgs, lazyvim, ... }:
{
  imports = [ lazyvim.homeManagerModules.default ];

  programs.lazyvim = {
    enable = true;

    extraPackages = with pkgs; [
      nixd
      nixfmt
      statix
    ];

    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      glsl
      wgsl
    ];

    extras = {
      lang = {
        nix = {
          enable = true;

          config = ''
            return {
              {
                "neovim/nvim-lspconfig",
                opts = {
                  servers = {
                    nil_ls = false,
                    nixd = {},
                  },
                },
              },
            }
          '';
        };
        python = {
          enable = true;
          installDependencies = true;
          installRuntimeDependencies = true;
        };
        java.enable = true;
        json.enable = true;
        yaml.enable = true;
        markdown.enable = true;
      };

      util = {
        gh.enable = true;
        rest.enable = true;
      };
    };
  };
}
