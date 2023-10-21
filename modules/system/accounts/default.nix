
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.accounts;
in

{
  options.accounts = {
    zaha.enable = mkEnableOption "Enable user zaha";
    zaha-odoo.enable = mkEnableOption "Enable user zaha-odoo";
  };
  config = {
    users.users.zaha = mkIf cfg.zaha.enable {
      isNormalUser = true;
      description = "Zachary Hanham - personal";
      extraGroups = [ "networkmanager" "wheel" "realtime" ];
    };
    users.users.zaha-odoo = mkIf cfg.zaha.enable {
      isNormalUser = true;
      description = "Zachary Hanham - work";
      extraGroups = [ "networkmanager" "wheel" "realtime" ];
    };
  };
}
