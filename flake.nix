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
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = pkg: true;
        # overlays = [ overlay xmonad.overlay xmonad-contrib.overlay ];
      };
      stylix-config = {
        image = ./files/wallpaper;
        base16Scheme = import ./files/scheme.nix;
        enable = true;
        polarity = "dark";
        opacity.terminal = 0.4;
        cursor = {
          package = pkgs.catppuccin-cursors.mochaRosewater;
          name = "catppuccin-mocha-rosewater-cursors";
          size = 32;
        };
        fonts = {
          serif = {
            package = pkgs.noto-fonts;
            name = "Noto Serif";
          };

          sansSerif = {
            package = pkgs.noto-fonts;
            name = "Noto Sans";
          };

          monospace = {
            package = pkgs.nerdfonts.override {
              fonts = [
                "Iosevka"
              ];
            };
            name = "Iosevka NFM";
          };

          emoji = {
            package = pkgs.noto-fonts-emoji;
            name = "Noto Color Emoji";
          };
        };
      };
      homeArgs = {
        inherit stylix-config;
        homeFilesPath = ./files/home;
        homeModulesPath = ./modules/home;
        username = "z";
      };
      systemArgs = {
        inherit overlay stylix-config homeArgs;
        home-modules = import ./users/z.nix;
        systemModulesPath = ./modules/system;
        nixvimModule = nixvim.homeManagerModules.nixvim;
        impermanenceModule = impermanence.homeManagerModules.impermanence;
      };
      maintainers.zackattackz = {
        email = "z@zmhanham.com";
        github = "zackattackz";
        githubId = 39349995;
        name = "Zachary Hanham";
      };
      overlay = final: prev: {
      };
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in {
      homeConfigurations."z@nyx" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/z.nix
          nixvim.homeManagerModules.nixvim
          stylix.homeManagerModules.stylix
        ];
        extraSpecialArgs = homeArgs // {
          username = "z";
        };
      };
      homeConfigurations."z@hermes" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/z.nix nixvim.homeManagerModules.nixvim ];
        extraSpecialArgs = homeArgs // {
          username = "z";
          system = "hermes";
        };
      };
      nixosConfigurations."nyx" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./systems/nyx.nix stylix.nixosModules.stylix home-manager.nixosModules.home-manager impermanence.nixosModules.impermanence ];
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
