{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.impermanence;
in
{
  options.impermanence.enable = mkEnableOption "impermanenece";
  config = mkIf cfg.enable {
    programs.fuse.userAllowOther = true;
    environment.persistence."/persistent" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/log"
        "/var/lib/bluetooth"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
      ];
      files = [
        "/etc/machine-id"
        "/crypto_keyfile.bin"
      ];
      users.z = {
        directories = [
          "downloads"
          "src"
          "pictures"
          "documents"
          "videos"
          ".cache"
          ".mozilla"
          ".steam"
          ".local/share/Steam"
          ".local/share/direnv"
          ".local/share/lutris"
          ".local/share/nvim"
          ".config/vesktop"
          { directory = ".gnupg"; mode = "0700"; }
          { directory = ".ssh"; mode = "0700"; }
          { directory = ".local/share/keyrings"; mode = "0700"; }
        ];
        files = [
        ];
      };
    };
  };
}
