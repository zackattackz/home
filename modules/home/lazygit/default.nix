{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.lazygit;
in
{
  options.lazygit.enable = mkEnableOption "lazygit";
  config = mkIf cfg.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        disableStartupPopups = true;
        notARepository = "skip";
        update.method = "never";
      };
    };
  };
}
