{
  description = "Home Manager configuration of zaha";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = pkg: true;
        overlays = [ overlay ];
      };
      homeArgs = { username, ... }: {
        inherit username;
        homeFilesPath = ./files/home;
        homeModulesPath = ./modules/home;
      };
      systemArgs = {
        inherit overlay;
        systemModulesPath = ./modules/system;
      };
      maintainers.zackattackz = {
        email = "z@zmhanham.com";
        github = "zackattackz";
        githubId = 39349995;
        name = "Zachary Hanham";
      };
      overlay = final: prev: {
        atlasvpn = import ./pkgs/applications/networking/atlasvpn { inherit maintainers; } pkgs;
      };
    in {
      homeConfigurations."zaha@nyx" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/zaha.nix ];
        extraSpecialArgs = homeArgs {
          username = "zaha";
        };
      };
      homeConfigurations."zaha@hermes" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/zaha.nix ];
        extraSpecialArgs = homeArgs {
          username = "zaha";
        };
      };
      nixosConfigurations."nyx" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./systems/nyx.nix ];
        specialArgs = systemArgs;
      };
      nixosConfigurations."hermes" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./systems/hermes.nix ];
        specialArgs = systemArgs;
      };
    };
}
