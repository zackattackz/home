{ config, pkgs, args, ...}:
let
colors = import ./colors/${args.theme}.nix;
in
{
  programs.alacritty.settings.colors = {
    primary = {
      background = "#${colors.base00}";
      foreground = "#${colors.base04}";
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
}

