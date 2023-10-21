{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.alacritty;
in
{
  options.alacritty = {
    enable = mkEnableOption "Alacritty options";
  };
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window.opacity = 0.83;
        font = {
          normal = {
            family = globals.fontFamily;
            style = "Regular";
          };
          bold = {
            family = globals.fontFamily;
            style = "Bold";
          };
          italic = {
            family = globals.fontFamily;
            style = "Italic";
          };
          bold_italic = {
            family = globals.fontFamily;
            style = "Bold Italic";
          };
          size = 13.0 ;
        };
      };
    };
  };
}
