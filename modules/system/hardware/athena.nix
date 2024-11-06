{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      ./default.nix
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "sr_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/mapper/crypto";
      fsType = "btrfs";
      options = [ "subvol=root" "compress=zstd" "noatime" ];
    };

  boot.initrd.luks.devices."crypto".device = "/dev/sda2";

  fileSystems."/boot" =
    { device = "/dev/sda1";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  fileSystems."/nix" =
    { device = "/dev/mapper/crypto";
      fsType = "btrfs";
      options = [ "subvol=nix" "compress=zstd" "noatime" ];
    };

  fileSystems."/persistent" =
    { device = "/dev/mapper/crypto";
      neededForBoot = true;
      fsType = "btrfs";
      options = [ "subvol=persistent" "compress=zstd" "noatime" ];
    };


  swapDevices = [ ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
