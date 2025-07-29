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
          plugins = pkgs.callPackage ./vim-plugins.nix {};
        };
        path = with pkgs;
          [
            # nix
            alejandra
            nixfmt-rfc-style
            nixpkgs-fmt
            statix
            nil

            # yaml
            ansible
            ansible-lint
            ansible-language-server
            yamllint

            # c/c++
            astyle
            clang
            cppcheck
            cmake-format
            llvmPackages_21.clang-tools

            # python
            (python311.withPackages (ps:
              with ps; [
                python-lsp-server
                python-lsp-ruff
                python-lsp-black
                pylsp-rope
                pylsp-mypy
                pyls-isort
              ]))
            pylint
            pyright
            ruff
            black
            python3

            # lua
            stylua
            selene
            lua-language-server

            # rust
            rust-bin.stable."1.81.0".default
            rustc
            cargo
            rust-analyzer
            rustfmt

            # go
            golangci-lint
            gofumpt
            golines
            gotools

            # sh
            shellcheck
            shfmt

            # markdown
            marksman

            # misc
            codeium
            node18Pkgs.nodejs_18
            moldPkgs.mold
            curl
            ripgrep
            git
            postgresql
            pkg-config
            zig
          ]
          ++ pkgs.callPackage ./node-pkgs.nix {customNodeJS = node18Pkgs.nodejs_18;};
      };
    in {
      packages = {
        default = inputs.tolerable.makeNeovimConfig "config" neovimConfig;
        neovim = inputs.tolerable.makeNeovimConfig "config" neovimConfig;
        neovim-nightly = inputs.tolerable.makeNightlyNeovimConfig "config" neovimConfig;
        testing = inputs.tolerable.makeNeovimConfig "config" (
          neovimConfig
          // {
            testing = true;
          }
        );
        testing-nightly = inputs.tolerable.makeNightlyNeovimConfig "config" (
          neovimConfig
          // {
            testing = true;
          }
        );
      };
    });
}
