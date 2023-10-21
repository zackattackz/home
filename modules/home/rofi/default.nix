{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.rofi;
in
{
  options.rofi.enable = mkEnableOption "rofi options";
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      font = "${globals.fontFamily} 13";
      extraConfig = {
        kb-row-up = "Up,Control+k,ISO_Left_Tab";
        kb-row-down = "Down,Control+j,Tab";
        kb-accept-entry = "Control+p,Return,KP_Enter";
        kb-remove-to-eol = "";
        kb-element-next = "";
        kb-element-prev = "";
      };
    };
  };
}
