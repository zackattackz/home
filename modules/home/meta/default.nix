{ config, lib, pkgs, globals, ... }:

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

    home.username = globals.username;
    home.homeDirectory = globals.homeDirectory;

    home.stateVersion = "23.05";
    programs.home-manager.enable = true;
  };
}
