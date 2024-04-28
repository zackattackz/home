{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.mpd;
  cfg-musicDir = config.xfg.userDirs.music;
in
{
  options.mpd.enable = mkEnableOption "mpd";
  config = mkIf cfg.enable {
    programs.ncmpcpp = {
      enable = true;
      mpdMusicDir = cfg-musicDir;
    };
    services.mpd {
      enable = true;
    };
  };
}
