
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.libinput;
in

{
  options.libinput = {
    enable = mkEnableOption "libinput";
    dev = mkOption {
      type = types.str;
      default = null;
    };
  };
  config = mkIf cfg.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        dev = mkIf (cfg.dev != null) cfg.dev;
        disableWhileTyping = true;
        naturalScrolling = true;
      };
    };
  };
}
