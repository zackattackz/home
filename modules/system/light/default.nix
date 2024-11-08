{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.light;
in
{
  options.light = {
    enable = mkEnableOption "backlight control";
    users = mkOption {
      type = types.listOf types.str;
      default = [];
    };
  };
  config = mkIf cfg.enable {
    programs.light.enable = true;
    users.users = listToAttrs
      (map (user: { name = user; value = { extraGroups = ["video"];};}) cfg.users);
  };
}
