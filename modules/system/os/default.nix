{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.os;
in
{
  options.os.enable = mkEnableOption "misc options relating to backend system config";
  config = mkIf cfg.enable {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    programs.dconf.enable = true;

    security.pam.loginLimits = [
      {
        domain = "zaha";
        item = "nofile";
        value = "524288";
      }
      {
        domain = "@realtime";
        item = "rtprio";
        value = "99";
      }
      {
        domain = "@realtime";
        item = "memlock";
        value = "unlimited";
      }
    ];


    services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';
  };
}
