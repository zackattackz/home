{ config, lib, pkgs, ...}:

with lib;

let
  cfg = config.misc.themes;
  colors = import ./colors/${cfg.theme}.nix;
in
{
  options.misc.themes = {
    enable = mkEnableOption "set color options in various modules based on theme"; theme = mkOption {
      type = types.str;
      example = "nord";
      description = "name of the theme file to use";
    };
  };
  config = mkIf cfg.enable {
    programs.alacritty.settings.colors = {
      primary = {
        background = "#${colors.base00}";
        foreground = "#${colors.base06}";
      };
      normal = {
        black = "#${colors.base01}";
        red = "#${colors.base08}";
        green = "#${colors.base0B}";
        yellow = "#${colors.base0A}";
        blue = "#${colors.base0D}";
        magenta = "#${colors.base0E}";
        cyan = "#${colors.base0C}";
        white = "#${colors.base05}";
      };
      bright = {
        black = "#${colors.base03}";
        red = "#${colors.base08}";
        green = "#${colors.base0B}";
        yellow = "#${colors.base0A}";
        blue = "#${colors.base0D}";
        magenta = "#${colors.base0E}";
        cyan = "#${colors.base07}";
        white = "#${colors.base06}";
      };
    };
    
    services.dunst.settings = {
      global = {
        frame_color = "#${colors.base0F}";
      };
      urgency_low = {
        background = "#${colors.base00}";
        foreground = "#${colors.base04}";
      };
      urgency_normal = {
        background = "#${colors.base01}";
        foreground = "#${colors.base06}";
      };
      urgency_critical = {
        background = "#${colors.base01}";
        foreground = "#${colors.base09}";
      };
    };

    xsession.windowManager.bspwm.settings = {
      focused_border_color = "#${colors.base0B}";
      normal_border_color = "#${colors.base03}";
    };

    services.flameshot.settings.General.uiColor = "#${colors.base0F}";

    services.polybar.settings = {
      "colors" = {
        background = "#${colors.base00}";
        background-alt = "#${colors.base01}";
        foreground = "#${colors.base06}";
        foreground-alt = "#${colors.base04}";
        primary = "#${colors.base0C}";
        secondary = "#${colors.base0E}";
        alert = "#${colors.base08}";
      };
      "bar/main" = {
        background = "#${colors.base00}";
        foreground = "#${colors.base06}";
        border-color = "#${colors.base0F}";
        line-color = "#${colors.base07}";
      };
      "module/bspwm" = {
        label-focused-foreground = "#${colors.base06}";
        label-focused-background = "#${colors.base00}";
        label-focused-underline = "#${colors.base0B}";
        label-occupied-underline = "#${colors.base0E}";
        label-urgent-foreground = "#${colors.base0C}";
        label-urgent-background = "#${colors.base08}";
        label-urgent-underline = "#${colors.base0A}";
        label-separator-foreground = "#${colors.base06}";
      };
      "module/wireless-network" = {
        format-connected-underline = "#${colors.base0E}";
        ramp-signal-foreground = "#${colors.base04}";
      };
      "module/wired-network" = {
        format-connected-underline = "#${colors.base0E}";
        format-connected-prefix-foreground = "#${colors.base04}";
        format-disconnected-underline = "#${colors.base08}";
      };
      "module/date" = {
        format-underline = "#${colors.base0E}";
        format-prefix-foreground = "#${colors.base04}";
      };
    };

    programs.rofi.theme = with config.lib.formats.rasi; {
      "*" = {
          active-background = mkLiteral "#${colors.base0B}";
          active-foreground = mkLiteral "@foreground";
          normal-background = mkLiteral "@background";
          normal-foreground = mkLiteral "@foreground";
          urgent-background = mkLiteral "#${colors.base08}";
          urgent-foreground = mkLiteral "@foreground";
          alternate-active-background = mkLiteral "@background";
          alternate-active-foreground = mkLiteral "@foreground";
          alternate-normal-background = mkLiteral "@background";
          alternate-normal-foreground = mkLiteral "@foreground";
          alternate-urgent-background = mkLiteral "@background";
          alternate-urgent-foreground = mkLiteral "@foreground";
          selected-active-background = mkLiteral "#${colors.base0F}";
          selected-active-foreground = mkLiteral "@foreground";
          selected-normal-background = mkLiteral "#${colors.base0F}";
          selected-normal-foreground = mkLiteral "@foreground";
          selected-urgent-background = mkLiteral "#${colors.base0F}";
          selected-urgent-foreground = mkLiteral "@foreground";
          background-color = mkLiteral "@background";
          background = mkLiteral "#${colors.base00}";
          foreground = mkLiteral "#${colors.base06}";
          border-color = mkLiteral "@background";
          spacing = 2;
      };
      "#window" = {
          background-color = mkLiteral "@background";
          border = mkLiteral "2px";
          border-color = mkLiteral "@selected-normal-background";
          padding = mkLiteral "2.5ch";
      };
      "#mainbox" = {
          border = 0;
          padding = 0;
      };
      "#message" = {
          border = mkLiteral "2px 0px 0px";
          border-color = mkLiteral "@border-color";
          padding = mkLiteral "1px";
      };
      "#textbox" = {
          text-color = mkLiteral "@foreground";
      };
      "#inputbar" = {
          children = map mkLiteral [
            "prompt"
            "textbox-prompt-colon"
            "entry"
            "case-indicator"
          ];
      };
      "#textbox-prompt-colon" = {
          expand = false;
          str = ":";
          margin = mkLiteral "0px 0.3em 0em 0em";
          text-color = mkLiteral "@normal-foreground";
      };
      "#listview" = {
          fixed-height = 0;
          border = mkLiteral "2px 0px 0px";
          border-color = mkLiteral "@border-color";
          spacing = mkLiteral "2px";
          scrollbar = true;
          padding = mkLiteral "2px 0px 0px";
      };
      "#element" = {
          border = 0;
          padding = mkLiteral "1px";
      };
      "#element.normal.normal" = {
          background-color = mkLiteral "@normal-background";
          text-color = mkLiteral "@normal-foreground";
      };
      "#element.normal.urgent" = {
          background-color = mkLiteral "@urgent-background";
          text-color = mkLiteral "@urgent-foreground";
      };
      "#element.normal.active" = {
          background-color = mkLiteral "@active-background";
          text-color = mkLiteral "@active-foreground";
      };
      "#element.selected.normal" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-foreground";
      };
      "#element.selected.urgent" = {
          background-color = mkLiteral "@selected-urgent-background";
          text-color = mkLiteral "@selected-urgent-foreground";
      };
      "#element.selected.active" = {
          background-color = mkLiteral "@selected-active-background";
          text-color = mkLiteral "@selected-active-foreground";
      };
      "#element.alternate.normal" = {
          background-color = mkLiteral "@alternate-normal-background";
          text-color = mkLiteral "@alternate-normal-foreground";
      };
      "#element.alternate.urgent" = {
          background-color = mkLiteral "@alternate-urgent-background";
          text-color = mkLiteral "@alternate-urgent-foreground";
      };
      "#element.alternate.active" = {
          background-color = mkLiteral "@alternate-active-background";
          text-color = mkLiteral "@alternate-active-foreground";
      };
      "#scrollbar" = {
          width = mkLiteral "4px";
          border = 0;
          handle-width = mkLiteral "8px";
          padding = 0;
      };
      "#sidebar" = {
          border = mkLiteral "2px 0px 0px";
          border-color = mkLiteral "@border-color";
      };
      "#button" = {
          text-color = mkLiteral "@normal-foreground";
      };
      "#button.selected" = {
          background-color = mkLiteral "@selected-normal-background";
          text-color = mkLiteral "@selected-normal-foreground";
      };
      "#inputbar" = {
          spacing = 0;
          text-color = mkLiteral "@normal-foreground";
          padding = mkLiteral "1px";
      };
      "#case-indicator" = {
          spacing = 0;
          text-color = mkLiteral "@normal-foreground";
      };
      "#entry" = {
          spacing = 0;
          text-color = mkLiteral "@normal-foreground";
      };
      "#prompt" = {
          spacing = 0;
          text-color = mkLiteral "@normal-foreground";
      };
      "element-text" = {
          background-color = mkLiteral "inherit";
          text-color = mkLiteral "      inherit";
      };
      "element-icon" = {
          background-color = mkLiteral "inherit";
      };
    };
  };
}
