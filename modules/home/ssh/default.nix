{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.ssh;
  homeCfg = config.home;
in
{
  options.ssh = {
    enable = mkEnableOption "ssh options";
    zaha.enable = mkEnableOption "personal id";
    zaha-odoo.enable = mkEnableOption "odoo id";
  };
  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "zackattackz" = mkIf cfg.zaha.enable {
          hostname = "github.com";
          user = "z.hanham00@gmail.com";
          identityFile = "${homeCfg.homeDirectory}/.ssh/id_ed25519";
          identitiesOnly = true;
        };
        "zaha-odoo" = mkIf cfg.zaha-odoo.enable {
          hostname = "github.com";
          user = "zaha@odoo.com";
          identityFile = "${homeCfg.homeDirectory}/.ssh/id_odoo";
          identitiesOnly = true;
        };
      };
    };
  };
}
