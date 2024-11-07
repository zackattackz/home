{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.gpg;
in
{
  options.gpg.enable = mkEnableOption "gpg";
  config = mkIf cfg.enable {
    programs.gpg.enable = true;
    services.gpg-agent.enable = true;
    impermanence.extraDirs = [ ".gnupg" ];
  };
}
