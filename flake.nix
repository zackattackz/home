{
  description = "Home Manager configuration of zaha";

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
    xmonad.url = "github:xmonad/xmonad";
    xmonad-contrib.url = "github:liskin/xmonad-contrib/steam-fixes"; # "github:xmonad/xmonad-contrib";
    snowdoo-support.url = "git+ssh://git@github.com/zaha-odoo/snowdoo-support";
  };

  outputs = { nixpkgs, home-manager, nixvim, snowdoo-support, xmonad, xmonad-contrib, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = pkg: true;
        overlays = [ overlay xmonad.overlay xmonad-contrib.overlay ];
      };
      homeArgs = {
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
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in {
      homeConfigurations."zaha@nyx" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/zaha.nix snowdoo-support.homeManagerModules.oe-support nixvim.homeManagerModules.nixvim ];
        extraSpecialArgs = homeArgs // {
          username = "zaha";
        };
      };
      homeConfigurations."zaha@hermes" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/zaha.nix nixvim.homeManagerModules.nixvim ];
        extraSpecialArgs = homeArgs // {
          username = "zaha";
          system = "hermes";
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
      devShells = forEachSupportedSystem ({ pkgs }: {
        default = pkgs.mkShell {
          packages = with pkgs; [ ghc ];
        };
      });
    };
}
