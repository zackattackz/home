# home.file configurations.

{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.file;
in
{
  options.file = {
    enable = mkEnableOption "home.file options";
    autorandrBspcCmds = lib.mkOption {
       description = "mapping autorandr profile name to cmd to run after load";
       type = with types; attrsOf str;
    };
  };
  config = mkIf cfg.enable {
    home.file =
    let
      wallpaperRepoPath = globals.filesPath + /wallpapers/${globals.wallpaper};
    in
    {
      ".local/bin/alacritty-keep-cwd".source = globals.filesPath + /alacritty-keep-cwd;
      ".local/bin/bspc-node-focus".source = globals.filesPath + /bspc-node-focus;
      ".local/bin/bspc-node-swap".source = globals.filesPath + /bspc-node-swap;
      ".local/bin/bspc-close-all-quit".source = globals.filesPath + /bspc-close-all-quit;
      ".local/bin/bspc-northsouth-focus".source = globals.filesPath + /bspc-northsouth-focus;
      ".local/bin/rofi-autorandr".source = globals.filesPath + /rofi-autorandr;
      ".local/bin/rofi-pulse-profile".source = globals.filesPath + /rofi-pulse-profile;
      ".local/bin/rofi-pulse-select".source = globals.filesPath + /rofi-pulse-select;
      ".local/bin/external_rules_command".source = globals.filesPath + /external_rules_command;
      ".local/bin/sss".source = globals.filesPath + /sss;
      ".local/bin/screenshot".source = globals.filesPath + /screenshot;
      "${globals.wallpaperPath}".source = wallpaperRepoPath;
      ".config/rofi-autorandr-bspc-cmds".text =
        (strings.concatMapStrings
          (s: s + "\n")
          (attrsets.mapAttrsToList
            (k: v: "AUTORANDR_BSPC_CMD_${k}='${v}'")
            cfg.autorandrBspcCmds));
    };
  };
}
