{
  inputs = {
    # nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

    # pinned nixpkgs
    node18-nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/8b27c12.tar.gz";
    mold-nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/e0ed589d7422c1d7a1bdd1e81289e2428c6ec2a3.zip";

    # rust
    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";

    # neovim
    tolerable.url = "github:wires-org/tolerable-nvim-nix";
    tolerable.inputs.nixpkgs.follows = "nixpkgs";

    # nix utility fns
    flake-utils.url = "github:numtide/flake-utils";
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    node18-nixpkgs,
    mold-nixpkgs,
    rust-overlay,
    tolerable,
    flake-utils,
    ...
  } @ inputs:
    flake-utils.lib.eachSystem ["x86_64-linux" "aarch64-darwin"] (system: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [rust-overlay.overlays.default];
        config.allowUnfree = true;
      };
      node18Pkgs = import node18-nixpkgs {
        inherit system;
        config.allowBroken = true;
      };
      moldPkgs = import mold-nixpkgs {
        inherit system;
        config.allowBroken = true;
      };

      neovimConfig = {
        inherit pkgs;
        src = pkgs.lib.fileset.toSource {
          root = ./.;
          fileset = ./config;
        };
        config = {
          plugins = with pkgs.vimPlugins;
            [
              nvim-cmp
              gruvbox-nvim
              vim-fugitive
              mini-icons
              none-ls-nvim
              conform-nvim
              vim-prettier
              plenary-nvim
              telescope-nvim
              telescope-fzf-native-nvim
              telescope-file-browser-nvim
              telescope-dap-nvim
              nvim-dap
              nvim-dap-virtual-text
              nvim-dap-view
              nvim-dap-ui
              nvim-dap-rr
              nvim-dap-python
              nvim-dap-lldb
              nvim-cursorline
              nvim-tree-lua
              harpoon2
              luasnip
              windsurf-vim
              undotree
              oil-nvim
            ]
            ++ pkgs.callPackage ./vim-plugins.nix {};
        };
        path = with pkgs;
          [
            # nix
            alejandra
            nixfmt-rfc-style
            nixpkgs-fmt
            statix

            # yaml
            yamllint

            # c/c++
            astyle
            clang
            cppcheck

            # python
            mypy

            # lua
            stylua
            selene
            lua-language-server

            # rust
            rust-bin.stable."1.81.0".default
            rustc
            cargo
            rust-analyzer

            # misc
            codeium
            node18Pkgs.nodejs_18
            moldPkgs.mold
            curl
            ripgrep
            git
            postgresql
            pkg-config
          ]
          ++ pkgs.callPackage ./node-pkgs.nix {customNodeJS = node18Pkgs.nodejs_18;};
      };
    in {
      packages = {
        default = inputs.tolerable.makeNightlyNeovimConfig "config" neovimConfig;
        neovim = inputs.tolerable.makeNightlyNeovimConfig "config" neovimConfig;
        testing = inputs.tolerable.makeNightlyNeovimConfig "config" (
          neovimConfig
          // {
            testing = true;
          }
        );
      };
    });
}
