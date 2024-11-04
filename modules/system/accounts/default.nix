
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
    users.mutableUsers = false;
    users.users.z = mkIf cfg.z.enable {
      isNormalUser = true;
      description = "Zachary Hanham";
      extraGroups = [ "networkmanager" "wheel" "realtime" ];
      hashedPasswordFile = "/persistent/passwords/z";
    };
    users.users.root.hashedPasswordFile = "/persistent/passwords/root";
  };
}
