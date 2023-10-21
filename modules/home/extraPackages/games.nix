{config, lib, pkgs, globals, ...}:

with lib;

let
  cfg = config.extraPackages.games;
in
{
  options.extraPackages.games = {
    enable = mkEnableOption "Packages needed for games";
  };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      steam
      lutris
      protonup-qt
    ];
  };
}
