
{config, lib, pkgs, systemModulesPath, homeArgs, home-modules, impermanenceModule, nixvimModule, stylix-config, system, ...}:

{
  imports = [
    (systemModulesPath + /accounts)
    (systemModulesPath + /avahi)
    (systemModulesPath + /bluetooth)
    (systemModulesPath + /bootloader)
    (systemModulesPath + /desktop)
    (systemModulesPath + /displaymanager)
    (systemModulesPath + /docker)
    (systemModulesPath + /gamemode)
    (systemModulesPath + /geoclue2)
    (systemModulesPath + /i3-sway)
    (systemModulesPath + /impermanence)
    (systemModulesPath + /locale)
    (systemModulesPath + /network)
    (systemModulesPath + /nix-ld)
    (systemModulesPath + /nvidia)
    (systemModulesPath + /os)
    (systemModulesPath + /pipewire)
    (systemModulesPath + /podman)
    (systemModulesPath + /postgres)
    (systemModulesPath + /steam)
    (systemModulesPath + /virt)
    (systemModulesPath + /vpn)
    (systemModulesPath + /waydroid)
    (systemModulesPath + /wayland)
    (systemModulesPath + /xserver)
  ];
  # nixpkgs.overlays = [ overlay ];
  system.stateVersion = "23.05";
  stylix = stylix-config;
  nix.settings.experimental-features = ["flakes" "nix-command"];
  home-manager = {
    users.z = home-modules;
    sharedModules = [ nixvimModule impermanenceModule ];
    extraSpecialArgs = homeArgs // { inherit system; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };
}
