{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.impermanence;
in
{
  options.impermanence.enable = mkEnableOption "impermanence";
  options.impermanence.extraDirs = mkOption {
    type = types.listOf types.str;
    default = [];
  };
  options.impermanence.extraFiles = mkOption {
    type = types.listOf types.str;
    default = [];
  };
  options.impermanence.user = mkOption { type = types.str; };
  config = mkIf cfg.enable {
    home.persistence."/persistent/home/${cfg.user}" = {
      directories = [
        "downloads"
        "src"
        "pictures"
        "documents"
        "videos"
        ".cache"
      ] ++ cfg.extraDirs;
      files = [
      ] ++ cfg.extraFiles;
      allowOther = true;
    };
  };
}

