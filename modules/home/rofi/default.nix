{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.rofi;
  fontFamily = config.desktop.fontFamily;
in
{
  options.rofi.enable = mkEnableOption "rofi options";
  config = mkIf cfg.enable {
    programs.rofi = {
      enable = true;
      font = "${fontFamily} 13";
      extraConfig = {
        kb-row-up = "Up,Control+k,ISO_Left_Tab";
        kb-row-down = "Down,Control+j,Tab";
        kb-accept-entry = "Control+p,Return,KP_Enter";
        kb-remove-to-eol = "";
        kb-element-next = "";
        kb-element-prev = "";
      };
    };
    home.packages = [
      (pkgs.writeShellScriptBin "rofi-arandr" ''
        set -e
        PROFILES_PATH='${config.home.homeDirectory}/.screenlayout'
        PROFILES=$(find $PROFILES_PATH/*)
        PROFILES=$(echo "$PROFILES" | xargs -I {} basename "{}")
        SELECTED_PROFILE=$(echo "$PROFILES" | rofi -dmenu)
        $PROFILES_PATH/$SELECTED_PROFILE
      '')
    ];
  };
}
