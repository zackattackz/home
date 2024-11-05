{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.picom;
in
{
  options.picom.enable = mkEnableOption "picom";
  config = mkIf cfg.enable {
    services.picom = {
      enable = true;
      backend = "glx";
      shadow = true;
      shadowOffsets = [ (-7) (-7) ];
      shadowOpacity = 0.75;
      activeOpacity = 1;
      inactiveOpacity = 1;
      opacityRules = [
        "0:_NET_WM_STATE@:32a *= '_NET_WM_STATE_HIDDEN'"
        "100:class_g = 'firefox' && argb"
        "100:class_g = 'discord'"
        #"100:class_g = 'Alacritty'"
        "100:class_g = 'steam'"
      ];
      vSync = true;
      wintypes = {
        tooltip = {
          shadow = true;
          opacity = 1;
          focus = true;
          full-shadow = false;
        };
        dock = {
          shadow = false;
          opacity = 1;
        };
        utility = {
          shadow = false;
          opacity = 1;
        };
        dnd = {
          shadow = false;
          opacity = 1;
        };
        popup_menu = {
          opacity = 1;
          shadow = false;
        };
        dropdown_menu = {
          opacity = 1;
          shadow = false;
        };
      };
      settings = {
        shadow-radius = 7;
        blur-kern = "3x3box";
        blur-background-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
        blur = {
          method = "dual_kawase";
          strength = 6;
          background = false;
          background-frame = false;
          background-fixed = false;
        };
        mark-wmwin-focused = true;
        mark-ovredir-focused = true;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        detect-transient = true;
        detect-client-leader = true;
        use-damage = true;
        use-ewmh-active-win = true;
        unredir-if-possible = true;
        glx-no-rebind-pixmap = true;
        xrender-sync-fence = true;
      };
    };
  };
}
