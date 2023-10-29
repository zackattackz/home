{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.docker;
in
{
  options.docker.enable = mkEnableOption "docker options";
  config = mkIf cfg.enable {
    virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };
}
