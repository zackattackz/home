{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.os;
in
{
  options.os.enable = mkEnableOption "misc options relating to backend system config";
  config = mkIf cfg.enable {
    #hardware.opengl = {
      #enable = true;
      #driSupport = true;
      #driSupport32Bit = true;
      #extraPackages = with pkgs; [
        #intel-media-driver # LIBVA_DRIVER_NAME=iHD
        #vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        #vaapiVdpau
        #libvdpau-va-gl
      #];
    #};
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel         # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    programs.dconf.enable = true;

    security.pam.loginLimits = [
      {
        # TODO for each user in users.users
        domain = "z";
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

    security.polkit.enable = true;

    services.udev.extraRules = ''
      KERNEL=="uinput", SUBSYSTEM=="misc", OPTIONS+="static_node=uinput", TAG+="uaccess"
    '';

    security.sudo.extraConfig = "Defaults lecture=\"never\"";

    # workaround for https://github.com/nix-community/impermanence/issues/229
    boot.initrd.systemd.suppressedUnits = [ "systemd-machine-id-commit.service" ];
    systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];
  };
}
