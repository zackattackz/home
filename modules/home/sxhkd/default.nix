{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.sxhkd;
in
{
  options.sxhkd.enable = mkEnableOption "sxhkd options";
  config = mkIf cfg.enable {
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "alacritty-keep-cwd";
        "super + w" = "firefox";
        "super + space" = "rofi -show drun";
        "super + {_,shift + } q" = "bspc node -{c,k}";
        "super + {1-9}" = "bspc desktop -f '^{1-9}'";
        "super + shift + {1-9}" = "bspc node -d '^{1-9}' --follow";
        "super + {j,k}" = "bspc-northsouth-focus {south,north}";
        "super + {h,l}" = "bspc-node-focus {west,east}";
        "super + button{4,5}" = "bspc desktop -f {next,prev}";
        "super + shift + {j,k}" = "bspc node -s {south,north}";
        "super + shift + {h,l}" = "bspc-node-swap {west,east}";
        "super + shift + control + q" = "bspc-close-all-quit";
        "super + t" = "bspc desktop -l next";
        "super + shift + t" = "bspc node -t ~fullscreen";
        "super + bracketright" = "[[ $(systemctl --user is-active picom) == \"active\" ]] && systemctl --user stop picom || systemctl --user start picom";
        "{_,shift +} Print" = "screenshot {yes,no} ${globals.picturesPath}/screenshots";
        "XF86AudioLowerVolume" = "ponymix decrease 5";
        "XF86AudioRaiseVolume" = "ponymix increase 5";
        "XF86AudioMute" = "ponymix toggle";
        "super + backslash" = "rofi-pulse-select sink";
        "super + shift backslash" = "rofi-pulse-select source";
      };
    };
  };
}
