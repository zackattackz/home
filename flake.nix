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
      packageGroups = import ./modules/package-groups;
    in {
      homeConfigurations."zaha" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/configuration.nix ];
        extraSpecialArgs = {
          cfg = {
            misc.themes = {
              enable = true;
              theme = "nord";
            };
            home.username = "zaha";
            home.getPackages = pkgs: (packageGroups.system pkgs) ++ (packageGroups.games pkgs);
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
