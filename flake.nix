{
  description = "Home Manager configuration of zaha";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:zackattackz/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xmonad.url = "github:xmonad/xmonad";
    xmonad-contrib.url = "github:xmonad/xmonad-contrib"; # "github:xmonad/xmonad-contrib";
    # snowdoo-support.url = "git+ssh://git@github.com/zaha-odoo/snowdoo-support";
    stylix.url = "github:danth/stylix";
  };

  outputs = { nixpkgs, home-manager, nixvim, xmonad, xmonad-contrib, stylix, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = pkg: true;
        overlays = [ overlay xmonad.overlay xmonad-contrib.overlay ];
      };
      stylix-config = {
        image = ./files/wallpaper.jpg;
        base16Scheme = import ./files/scheme.nix;
        enable = true;
        polarity = "dark";
        opacity.terminal = 0.83;
        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Original-Amber";
          size = 24;
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
      };
      systemArgs = {
        inherit overlay stylix-config;
        systemModulesPath = ./modules/system;
      };
      maintainers.zackattackz = {
        email = "z@zmhanham.com";
        github = "zackattackz";
        githubId = 39349995;
        name = "Zachary Hanham";
      };
      overlay = final: prev: {
        # atlasvpn = import ./pkgs/applications/networking/atlasvpn { inherit maintainers; } pkgs;
        rotification = import ./pkgs/rotification (pkgs // {zackattackz = maintainers.zackattackz;});
      };
      supportedSystems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forEachSupportedSystem = f: nixpkgs.lib.genAttrs supportedSystems (system: f {
        pkgs = import nixpkgs { inherit system; };
      });
    in {
      homeConfigurations."zaha@nyx" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/zaha.nix
          # snowdoo-support.homeManagerModules.oe-support
          nixvim.homeManagerModules.nixvim
          stylix.homeManagerModules.stylix
        ];
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
        modules = [ ./systems/nyx.nix stylix.nixosModules.stylix ];
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
