{config, lib, pkgs, ...}:

with lib;

let
  cfg = config.meta;
in
{
  options.meta.enable = mkEnableOption "options relating to operation of nix";
  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;
    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    system.stateVersion = "23.05"; # Did you read the comment?
  };
}
