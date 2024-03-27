{ config, lib, pkgs, ... }:

with lib;

let
  base-cfg = config.xsession.windowManager.i3;
  cfg = config.i3-sway;
  i3status-rust-cfg-file = "${config.xdg.configHome}/i3status-rust/config-default.toml";
  fontFamily = config.desktop.fontFamily;
in
{
  options.i3-sway = {
    enable = mkEnableOption "i3-sway";

  };
  config = mkIf cfg.enable {
    xsession.enable = true;
    xsession.scriptPath = ".xsession-hm";
    xsession.profilePath = ".xprofile-hm";
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        menu = "${pkgs.rofi}/bin/rofi -show drun";
        modifier = "Mod4";
        focus.followMouse = false;
        bars = [{
          mode = "dock";
          hiddenState = "hide";
          position = "top";
          workspaceButtons = true;
          workspaceNumbers = true;
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ${i3status-rust-cfg-file}";
          fonts = {
            names = [ fontFamily ];
            size = 10.0;
          };
          trayOutput = "primary";
          #extraConfig = ''
            #output 
          #'';
        }];
        keybindings = mkDefault {
          "${base-cfg.config.modifier}+Return" = "exec ${base-cfg.config.terminal}";
          "${base-cfg.config.modifier}+q" = "kill";
          "${base-cfg.config.modifier}+space" = "exec ${base-cfg.config.menu}";
          "${base-cfg.config.modifier}+w" = "exec firefox";

          "${base-cfg.config.modifier}+h" = "focus left";
          "${base-cfg.config.modifier}+j" = "focus down";
          "${base-cfg.config.modifier}+k" = "focus up";
          "${base-cfg.config.modifier}+l" = "focus right";

          "${base-cfg.config.modifier}+Shift+h" = "move left";
          "${base-cfg.config.modifier}+Shift+j" = "move down";
          "${base-cfg.config.modifier}+Shift+k" = "move up";
          "${base-cfg.config.modifier}+Shift+l" = "move right";

          "${base-cfg.config.modifier}+c" = "split h";
          "${base-cfg.config.modifier}+v" = "split v";
          "mod1+F11" = "fullscreen toggle";
          "${base-cfg.config.modifier}+F5" = "exec bash -c '[[ $(systemctl --user is-active picom) == \"active\" ]] && systemctl --user stop picom || systemctl --user start picom'";
          "${base-cfg.config.modifier}+i" = "layout stacking";
          "${base-cfg.config.modifier}+o" = "layout tabbed";
          "${base-cfg.config.modifier}+p" = "layout toggle split";

          "${base-cfg.config.modifier}+u" = "floating toggle";
          "${base-cfg.config.modifier}+y" = "focus mode_toggle";

          "${base-cfg.config.modifier}+n" = "focus parent";

          "${base-cfg.config.modifier}+Shift+t" = "move scratchpad";
          "${base-cfg.config.modifier}+t" = "scratchpad show";

          "${base-cfg.config.modifier}+grave" = "workspace number 1";
          "${base-cfg.config.modifier}+1" = "workspace number 2";
          "${base-cfg.config.modifier}+2" = "workspace number 3";
          "${base-cfg.config.modifier}+3" = "workspace number 4";
          "${base-cfg.config.modifier}+4" = "workspace number 5";

          "${base-cfg.config.modifier}+Shift+grave" =
            "move container to workspace number 1";
          "${base-cfg.config.modifier}+Shift+1" =
            "move container to workspace number 2";
          "${base-cfg.config.modifier}+Shift+2" =
            "move container to workspace number 3";
          "${base-cfg.config.modifier}+Shift+3" =
            "move container to workspace number 4";
          "${base-cfg.config.modifier}+Shift+4" =
            "move container to workspace number 5";
          
          "${base-cfg.config.modifier}+Shift+c" = "reload";
          "${base-cfg.config.modifier}+Shift+r" = "restart";
          "${base-cfg.config.modifier}+Shift+e" =
            "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

          "${base-cfg.config.modifier}+r" = "mode resize";
          "${base-cfg.config.modifier}+F6" = "exec rofi-arandr";
        };
      };
    };
  };
}
