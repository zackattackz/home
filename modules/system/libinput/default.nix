
{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.libinput;
in

{
  options.libinput = {
    enable = mkEnableOption "libinput";
  };
  config = mkIf cfg.enable {
    services.libinput = {
      enable = true;
      touchpad = {
        disableWhileTyping = true;
        naturalScrolling = true;
      };
    };
  };
}
