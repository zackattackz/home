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
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.allowUnfreePredicate = pkg: true;
      };
    in {
      homeConfigurations."zaha" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/zaha.nix
        ];
        extraSpecialArgs = rec {
          homeFilesPath = ./files/home;
          homeModulesPath = ./modules/home;
          globals = rec {
            username = "zaha";
            homeDirectory = "/home/${username}";
            fontFamily = "Iosevka NFM";
            wallpaper = "aurora1.png";
            picturesPath =  "${homeDirectory}/pictures";
            wallpaperPath = "${picturesPath}/wallpapers/${wallpaper}";
            filesPath = homeFilesPath;
          };

        };
      };
      nixosConfigurations."nyx" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./systems/nyx.nix ];
        specialArgs = {
          systemModulesPath = ./modules/system;
        };
      };
    };
}
