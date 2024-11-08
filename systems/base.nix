
{config, lib, pkgs, systemModulesPath, homeArgs, home-modules, impermanenceModule, nixvimModule, system, ...}:

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
    (systemModulesPath + /libinput)
    (systemModulesPath + /locale)
    (systemModulesPath + /network)
    (systemModulesPath + /nix-ld)
    (systemModulesPath + /nvidia)
    (systemModulesPath + /os)
    (systemModulesPath + /pipewire)
    (systemModulesPath + /podman)
    (systemModulesPath + /postgres)
    (systemModulesPath + /steam)
    (systemModulesPath + /stylix)
    (systemModulesPath + /virt)
    (systemModulesPath + /vpn)
    (systemModulesPath + /waydroid)
    (systemModulesPath + /wayland)
    (systemModulesPath + /xserver)
  ];
  # nixpkgs.overlays = [ overlay ];
  system.stateVersion = "23.05";
  nix.settings.experimental-features = ["flakes" "nix-command"];
  home-manager = {
    users.z = home-modules;
    sharedModules = [ nixvimModule impermanenceModule ];
    extraSpecialArgs = homeArgs // { inherit system; };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  accounts.z.enable = true;
  bluetooth.enable = true;
  bootloader.enable = true;
  bootloader.enableCryptoKeyfile = true;
  desktop.enable = true;
  displaymanager.enable = true;
  geoclue2.enable = true;
  i3-sway.enable = true;
  impermanence.enable = true;
  locale.enable = true;
  network.enable = true;
  nix-ld.enable = true;
  os.enable = true;
  pipewire.enable = true;
  podman.enable = true;
  postgres.enable = false;
  virt.enable = true;
  vpn.enable = true;
  waydroid.enable = false;
  # wayland.enable = true;
  xserver.enable = true;
}
