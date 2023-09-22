{
  description = "Home Manager configuration of zaha";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      packageSets = (import ./package-sets/package-sets.nix { inherit pkgs; });
    in {
      homeConfigurations."zaha" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home/configuration.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
        extraSpecialArgs = {
          cfg = {
            misc.themes = {
              enable = true;
              theme = "nord";
            };
            home.username = "zaha";
            home.packages = with packageSets; system ++ games;
          };
        };
      };
      nixosConfigurations."nyx" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./os/configuration.nix ];
        specialArgs = { cfg = { hardware.nvidia.enable = true; networking.hostName = "nyx"; }; };
      };
    };
}
