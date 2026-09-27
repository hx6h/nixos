{ pkgs, lazyvim, ... }:

# Neovim with LazyVim. The lazyvim-nix module exposes LazyVim as the
# programs.lazyvim option, where plugins, treesitter parsers and the binaries
# LazyVim expects are all built by Nix, so no plugin is downloaded on first
# launch. This is a Home Manager module, it is imported for
# home-manager.users.femboy in ./flake.nix.

{
  imports = [ lazyvim.homeManagerModules.default ];

  programs.lazyvim = {
    enable = true;

    # Tools the extras do not map to a nixpkgs package on their own.
    extraPackages = with pkgs; [
      nixd
      nixfmt
      statix
    ];

    # GLSL shaders live in ./dots/cava/shaders and ./dots/hypr/shaders.
    treesitterParsers = with pkgs.vimPlugins.nvim-treesitter-parsers; [
      glsl
      wgsl
    ];

    extras = {
      lang.nix = {
        enable = true;

        # The extra asks for nil_ls, which nixpkgs does not package, use nixd.
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

      lang.python = {
        enable = true;
        installDependencies = true;
        installRuntimeDependencies = true;
      };
      lang.java.enable = true;
      lang.json.enable = true;
      lang.yaml.enable = true;
      lang.markdown.enable = true;

      util.gh.enable = true;
      util.rest.enable = true;
    };
  };
}
