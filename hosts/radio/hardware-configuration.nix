{
  config,
  lib,
  pkgs,
  ...
}:

{

  hardware = {
    nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      package = pkgs.linuxPackages_cachyos-lto.nvidiaPackages.beta;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  };

  boot = {
    supportedFilesystems = lib.mkForce [
      "btrfs"
      "vfat"
    ];
    kernelPackages = pkgs.linuxPackages_cachyos-lto;
    kernelModules = lib.mkForce [
      "kvm-amd"
      "nvidia"
      "nvidia_modeset"
      "nvidia_drm"
      "nvidia_uvm"
      "btrfs"
    ];

    initrd = {
      preDeviceCommands = "";
      kernelModules = lib.mkForce [ "btrfs" ];
      availableKernelModules = [
        "nvidia"
        "nvidia_modeset"
        "nvidia_drm"
        "nvidia_uvm"
        "xhci_pci"
        "ahci"
        "nvme"
        "usb_storage"
        "usbhid"
        "sd_mod"
        "sr_mod"
      ];
      supportedFilesystems = lib.mkForce [
        "btrfs"
        "vfat"
      ];
      includeDefaultModules = false;
    };

    # extraModulePackages = with config.boot.kernelPackages; [ r8168 ];
    # blacklistedKernelModules = [ "r8169" ];

    loader = {
      efi.canTouchEfiVariables = true;
      limine = {
        enable = true;
        enableEditor = true;
      };
    };

    extraModprobeConfig = ''
      options nvidia_drm fbdev=1 modeset=1
    '';
  };

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b48e7966-0211-4185-9730-6e698a1f162d";
      fsType = "btrfs";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/B40E-E974";
      fsType = "vfat";
    };
  };

  networking = {
    hostName = "radio";
    useNetworkd = true;
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
      "192.168.1.200"
      "8.8.8.8"
      "8.8.4.4"
    ];
    ];

  };

}
