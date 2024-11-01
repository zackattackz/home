
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.accounts;
in

{
  options.accounts = {
    z.enable = mkEnableOption "Enable user z";
  };
  config = {
    users.users.z = mkIf cfg.z.enable {
      isNormalUser = true;
      description = "Zachary Hanham";
      extraGroups = [ "networkmanager" "wheel" "realtime" ];
    };
  };
}
