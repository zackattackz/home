{
  description = "Home Manager configuration of zaha";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/5a237aecb57296f67276ac9ab296a41c23981f56";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
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
      };
      homeArgs = usernameInput: firstMonitorInput: secondMonitorInput: rec {
        homeFilesPath = ./files/home;
        homeModulesPath = ./modules/home;
        globals = rec {
          username = usernameInput;
          homeDirectory = "/home/${username}";
          fontFamily = "Iosevka NFM";
          wallpaper = "aurora1.png";
          picturesPath =  "${homeDirectory}/pictures";
          wallpaperPath = "${picturesPath}/wallpapers/${wallpaper}";
          filesPath = homeFilesPath;
          firstMonitor = firstMonitorInput;
          secondMonitor = secondMonitorInput;
        };
      };
    in {
      homeConfigurations."zaha@nyx" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/zaha.nix
        ];
        extraSpecialArgs = homeArgs "zaha" "DP-0" "HDMI-0";
      };
      homeConfigurations."zaha-odoo@nyx" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/zaha-odoo.nix
        ];
        extraSpecialArgs = homeArgs "zaha-odoo" "DP-0" "HDMI-0";
      };
      homeConfigurations."zaha@hermes" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/zaha.nix
        ];
        extraSpecialArgs = homeArgs "zaha" "eDP-1" "HDMI-1";
      };
      homeConfigurations."zaha-odoo@hermes" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/zaha-odoo.nix
        ];
        extraSpecialArgs = homeArgs "zaha-odoo" "eDP-1" "HDMI-1";
      };
      nixosConfigurations."nyx" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./systems/nyx.nix ];
        specialArgs = {
          systemModulesPath = ./modules/system;
        };
      };
      nixosConfigurations."hermes" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./systems/hermes.nix ];
        specialArgs = {
          systemModulesPath = ./modules/system;
        };
      };
    };
}
