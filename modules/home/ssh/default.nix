{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.ssh;
  homeCfg = config.home;
in
{
  options.ssh = {
    enable = mkEnableOption "ssh options";
    z.enable = mkEnableOption "personal id";
  };
  config = mkIf cfg.enable {
    programs.ssh = {
      enable = true;
      matchBlocks = {
        "zackattackz" = mkIf cfg.z.enable {
          hostname = "github.com";
          user = "z.hanham00@gmail.com";
          identityFile = "${homeCfg.homeDirectory}/.ssh/id_ed25519";
          identitiesOnly = true;
        };
      };
    };
  };
}
