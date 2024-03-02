{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.pipewire;
in
{
  options.pipewire.enable = mkEnableOption "pipewire options";
  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    hardware.pulseaudio.enable = lib.mkForce false;
  };
}
