{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.autorandr;
  displays = import ./displays;
  profiles = import ./profiles/${cfg.machine}.nix { inherit lib pkgs displays; };
in
{
  options.autorandr.enable = mkEnableOption "autorandr";
  options.autorandr.machine = mkOption {
    type = types.enum [ "nyx" ];
  };
  config = mkIf cfg.enable {
    programs.autorandr = {
      inherit profiles;
      enable = true;
    };
  };
}
