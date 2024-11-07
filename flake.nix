{
  description = "System and Home flake for zmh";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix.url = "github:danth/stylix";
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { nixpkgs, home-manager, nixvim, stylix, impermanence, ... }:
    let
      system = "x86_64-linux";
      # overlay = final: prev: {
      # };
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = _: true;
        # overlays = [ some-overlays-here ];
      };
      homeArgs = {
        homeModulesPath = ./modules/home;
      };
      systemArgs = {
        # inherit overlay
        systemModulesPath = ./modules/system;
        inherit homeArgs;
        nixvimModule = nixvim.homeManagerModules.nixvim;
        impermanenceModule = impermanence.homeManagerModules.impermanence;
      };
      maintainers.zackattackz = {
        email = "z@zmhanham.com";
        github = "zackattackz";
        githubId = 39349995;
        name = "Zachary Hanham";
      };
    in {
      nixosConfigurations."nyx" = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [
          ./systems/nyx.nix
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          impermanence.nixosModules.impermanence
        ];
        specialArgs = systemArgs // { system = "nyx"; home-modules = import ./users/nyx/z.nix; };
      };
      nixosConfigurations."athena" = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        modules = [ ./systems/athena.nix stylix.nixosModules.stylix home-manager.nixosModules.home-manager impermanence.nixosModules.impermanence ];
        specialArgs = systemArgs // { system = "athena"; home-modules = import ./users/athena/z.nix; };
      };
      devShells = {
        default = pkgs.mkShell {
          packages = with pkgs; [ nixfmt-rfc-style ];
        };
      };
    };
}
