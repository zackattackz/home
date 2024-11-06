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
      };
      systemArgs = {
        # inherit overlay
        inherit stylix-config homeArgs;
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
