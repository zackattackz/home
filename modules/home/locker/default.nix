{ config, lib, pkgs, globals, ... }:

with lib;

let
  cfg = config.locker;
in
{
  options.locker.enable = mkEnableOption "Screen locker options";
  config = mkIf cfg.enable {
    home.packages = [ pkgs.lightlocker ];
    services.sxhkd.keybindings."super + shift + control + l" = "light-locker-command --lock";
    services.xidlehook = {
      enable = true;
      not-when-fullscreen = true;
      not-when-audio = true;
      timers =
      let
      minutes = 8;
      warningSeconds = 15;
      in
      [
        {
          # warn about screen lock
          delay = minutes * 60;
          command = "${pkgs.dunst}/bin/dunstify -p -u low -t ${toString ((warningSeconds - 1) * 1000)} 'Screen lock in ${toString warningSeconds} seconds' >> /tmp/lock_warning_notif_ids";
          canceller = "while IFS= read -r id; do ${pkgs.dunst}/bin/dunstify -C \"$id\"; done < /tmp/lock_warning_notif_ids; ${pkgs.coreutils-full}/bin/rm /tmp/lock_warning_notif_ids";
        }
        {
          # lock screen
          delay = warningSeconds;
          command = "${pkgs.lightlocker}/bin/light-locker-command --lock";
        }
      ];
    };
  };
}
