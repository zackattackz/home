{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.firefox;
  commonSettings = {
    "gfx.webrender.all" = true; # Force enable GPU acceleration
    "media.ffmpeg.vaapi.enabled" = true;
    "widget.dmabuf.force-enabled" = true; # Required in recent Firefoxes
    "privacy.webrtc.legacyGlobalIndicator" = false;
  };
in
{
  options.firefox.enable = mkEnableOption "firefox options";
  config = mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.personal = {
        id = 0;
        isDefault = true;
        settings = commonSettings;
      };
      profiles.work = {
        id = 1;
        settings = commonSettings;
      };
    };
    impermanence.extraDirs = [ ".mozilla" ];
  };
}
