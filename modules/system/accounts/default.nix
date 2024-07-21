
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.accounts;
in

{
  options.accounts = {
    zaha.enable = mkEnableOption "Enable user zaha";
  };
  config = {
    users.users.zaha = mkIf cfg.zaha.enable {
      isNormalUser = true;
      description = "Zachary Hanham";
      extraGroups = [ "networkmanager" "wheel" "realtime" ];
    };
  };
}
