{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.alacritty;
  cfg-desktop = config.desktop;
  # fontFamily = cfg-desktop.fontFamily;
in
{
  options.alacritty = {
    enable = mkEnableOption "alacritty";
  };
  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        env."WINIT_X11_SCALE_FACTOR" = "1";
        # window.opacity = 0.83;
       # font = {
       #   normal = {
       #     family = fontFamily;
       #     style = "Regular";
       #   };
       #   bold = {
       #     family = fontFamily;
       #     style = "Bold";
       #   };
       #   italic = {
       #     family = fontFamily;
       #     style = "Italic";
       #   };
       #   bold_italic = {
       #     family = fontFamily;
       #     style = "Bold Italic";
       #   };
       #   size = 13.0 ;
       # };
      };
    };
  };
}
