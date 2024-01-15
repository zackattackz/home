{ config, lib, pkgs, username, ... }:

with lib;

let
  cfg = config.meta;
in
{
  options.meta.enable = mkEnableOption "Module concerning all features related to direct operation of nix/home-manager.";
  config = mkIf cfg.enable {
    nix.package = pkgs.nix;

    nix.settings = {
      extra-experimental-features = ["flakes" "nix-command"];
    };

    nixpkgs.config.allowUnfreePredicate = (pkg: true);

    home = {
      inherit username;
      homeDirectory = "/home/${username}";
      stateVersion = "23.05";
    };

    programs.home-manager.enable = true;
  };
}
