{
  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";
  oldnixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/8b27c12.tar.gz";

  inputs.tolerable.url = "github:wires-org/tolerable-nvim-nix";
  inputs.tolerable.inputs.nixpkgs.follows = "nixpkgs";

  inputs.nightly.url = "github:nix-community/neovim-nightly-overlay";
  inputs.tolerable.inputs.nightly.follows = "nightly";

  outputs = {
    self,
    nixpkgs,
    oldnixpkgs,
    ...
  } @ inputs: let
    forAllSystems = function:
      nixpkgs.lib.genAttrs [
        "x86_64-linux"
        "x86_64-darwin"
        "aarch64-linux"
        "aarch64-darwin"
      ] (system: function nixpkgs.legacyPackages.${system});
  in {
    packages = forAllSystems (
      pkgs: let
        oldPkgs = import oldnixpkgs {
          inherit system;
          config.allowBroken = true;
        };
        tolerable = {
          inherit pkgs;
          src = pkgs.lib.fileset.toSource {
            root = ./.;
            fileset = ./config;
          };
          config = {
            plugins = with pkgs.vimPlugins;
              [
                gruvbox-nvim
                vim-fugitive
                coc-nvim
                coc-rust-analyzer
                coc-json
                coc-tsserver
                coc-eslint
                coc-pyright
                coc-tailwindcss
                telescope-nvim
              ]
              ++ pkgs.callPackage ./vim-plugins.nix {};
          };
          path = with pkgs;
            [
              lua-language-server
              oldPkgs.nodejs_18
              rustc
              cargo
              rust-analyzer
              curl
              ripgrep
              git
              clang
              mold
              postgresql
              pkg-config
            ]
            ++ pkgs.callPackage ./node-pkgs.nix {customNodeJS = oldPkgs.nodejs_18;};
        };
      in {
        neovim = inputs.tolerable.makeNightlyNeovimConfig "config" tolerable;
        testing = inputs.tolerable.makeNightlyNeovimConfig "config" (
          tolerable
          // {
            testing = true;
          }
        );
      }
    );
  };
}
