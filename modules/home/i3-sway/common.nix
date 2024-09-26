{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.i3-sway;
  i3status-rust-cfg-file = "${config.xdg.configHome}/i3status-rust/config-default.toml";
  wm-config = {
    config = {
      focus.followMouse = false;
      window.titlebar = false;
      floating.titlebar = true;
      bars = [
        ({
          position = "top";
          statusCommand = "i3status-rs ${i3status-rust-cfg-file}";
          workspaceButtons = true;
          workspaceNumbers = true;
          extraConfig = ''
            bindsym button4 nop
            bindsym button5 nop
            bindsym button6 nop
            bindsym button7 nop
          '';
        } // config.lib.stylix.i3.bar // {
          fonts = {
            inherit (config.lib.stylix.i3.bar.fonts) size;
            names = config.lib.stylix.i3.bar.fonts.names ++ [ "FontAwesome6Free" ];
          };
        })
      ];
      keybindings = mkDefault {
        "${cfg.modifier}+Return" = "exec ${cfg.terminal}";
        "${cfg.modifier}+q" = "kill";
        "${cfg.modifier}+space" = "exec ${cfg.menu}";
        "${cfg.modifier}+w" = "exec firefox";

        "${cfg.modifier}+h" = "focus left";
        "${cfg.modifier}+j" = "focus down";
        "${cfg.modifier}+k" = "focus up";
        "${cfg.modifier}+l" = "focus right";

        "${cfg.modifier}+Shift+h" = "move left";
        "${cfg.modifier}+Shift+j" = "move down";
        "${cfg.modifier}+Shift+k" = "move up";
        "${cfg.modifier}+Shift+l" = "move right";

        "${cfg.modifier}+c" = "split h";
        "${cfg.modifier}+v" = "split v";
        "${cfg.modifier}+y" = "fullscreen toggle";
        "${cfg.modifier}+F6" = "exec bash -c '[[ $(systemctl --user is-active picom) == \"active\" ]] && systemctl --user stop picom || systemctl --user start picom'";
        "${cfg.modifier}+F5" = "exec \"bash -c 'autorandr --cycle; ${pkgs.feh}/bin/feh --bg-center ${../../../files/wallpaper.jpg}'\"";
        "XF86AudioRaiseVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0";
        "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- --limit 1.0";
        "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "F3" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ --limit 1.0";
        "F2" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- --limit 1.0";
        "F4" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "${cfg.modifier}+i" = "layout stacking";
        "${cfg.modifier}+o" = "layout tabbed";
        "${cfg.modifier}+p" = "layout toggle split";

        "${cfg.modifier}+s" = "floating toggle";
        "${cfg.modifier}+x" = "focus mode_toggle";

        "${cfg.modifier}+n" = "focus parent";

        "${cfg.modifier}+Shift+t" = "move scratchpad";
        "${cfg.modifier}+t" = "scratchpad show";

        "${cfg.modifier}+grave" = "workspace number 1";
        "${cfg.modifier}+1" = "workspace number 2";
        "${cfg.modifier}+2" = "workspace number 3";
        "${cfg.modifier}+3" = "workspace number 4";
        "${cfg.modifier}+4" = "workspace number 5";

        "${cfg.modifier}+Shift+grave" =
          "move container to workspace number 1";
        "${cfg.modifier}+Shift+1" =
          "move container to workspace number 2";
        "${cfg.modifier}+Shift+2" =
          "move container to workspace number 3";
        "${cfg.modifier}+Shift+3" =
          "move container to workspace number 4";
        "${cfg.modifier}+Shift+4" =
          "move container to workspace number 5";

        "${cfg.modifier}+Shift+c" = "reload";
        "${cfg.modifier}+Shift+r" = "restart";
        "${cfg.modifier}+Shift+q" = "exit";

        "${cfg.modifier}+r" = "mode resize";
      };
    };
    extraConfig = ''
      bindsym --whole-window --border ${cfg.modifier}+button4 workspace next_on_output
      bindsym --whole-window --border ${cfg.modifier}+button5 workspace prev_on_output
    '';
  };
in

{
  options.i3-sway = {
    modifier = mkOption {
      type = types.str;
      default = "Mod4";
    };
    terminal = mkOption {
      type = types.str;
      default = "alacritty";
    };
    menu = mkOption {
      type = types.str;
    };
  };
  config = {
    i3status-rust.enable = true;
    xsession.windowManager.i3 = wm-config;
    wayland.windowManager.sway = wm-config;
  };
}
