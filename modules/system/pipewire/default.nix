{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.pipewire;
in
{
  options.pipewire.enable = mkEnableOption "pipewire options";
  config = mkIf cfg.enable {
    environment.etc."openal/alsoft.conf".text = ''
      [pulse]
      allow-moves=true
    '';
    services.pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    hardware.pulseaudio.enable = lib.mkForce false;
  };
}
