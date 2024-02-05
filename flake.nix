{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovimConfig = {
      url = "github:audishos/neovim-config";
      flake = false;
    };
    waybarConfig = {
      url = "github:rubyowo/dotfiles";
      flake = false;
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, neovimConfig, waybarConfig, ... }:
    let
      # system should match the system you are running on
      system = "x86_64-linux";
    in
    {
      devShells."${system}".default =
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        pkgs.mkShell {
          # create an environment with nodejs_18, pnpm, and yarn
          # packages = with pkgs; [
          #   nodejs_18
          #   nodePackages.pnpm
          #   (yarn.override { nodejs = nodejs_18; })
          # ];

          shellHook = ''
        '';
        };
      # {
      nixosConfigurations = {
        chungus = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./tuigreet.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.audisho = import ./home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
              home-manager.extraSpecialArgs = {
                neovimConfig = neovimConfig;
                waybarConfig = waybarConfig;
              };
            }
          ];
        };
      };
    };
}
