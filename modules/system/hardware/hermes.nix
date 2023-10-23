# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.initrd.luks.devices."luks-514c3473-5ea2-45d0-ad70-035499262736".device = "/dev/disk/by-uuid/514c3473-5ea2-45d0-ad70-035499262736";
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/ecf62c81-7dd3-40b5-a02a-0c036926c36a";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-7f320995-79a1-44d4-a7b4-fc383d2dfd93".device = "/dev/disk/by-uuid/7f320995-79a1-44d4-a7b4-fc383d2dfd93";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/BC5E-0449";
      fsType = "vfat";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/82d435a9-afcc-401b-84a9-e58bd7f28c0d"; }
    ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp2s0.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp3s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
