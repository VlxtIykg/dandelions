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
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

    bluetooth = {
      enable = true;
      powerOnBoot = false;
      settings = {
        General = {
          Experimental = true;
          FastConnectable = true;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };

  boot = {
    supportedFilesystems = lib.mkForce [
      "btrfs"
      "vfat"
    ];
    kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
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
        extraEntries = ''
          /Gaming (win-x86_64)
            protocol: efi
            path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
            comment: Yes
        '';
        # $\{RESOURCE_ARGUMENT}=59af7d50-eefa-4821-b24a-7cadf44d00c0
        extraConfig = ''
          timeout: 3
          wallpaper_style: stretched
          backdrop: FF3300
          verbose: yes
          interface_resolution: 1920x1080
          interface_branding: Mijn Liefde..
          interface_branding_color: 2
          term_font: boot():/EFI/limine/SCRWL---.F16
          term_font_size: 8x16
          term_font_scale: 2x2
          term_font_spacing: 1
          term_margin: 0
          term_margin_gradient: 0
          wallpaper: tftp():/limine/wallpapers/sunset-scenery-minimalist.jpeg
        '';
      };
    };

    extraModprobeConfig = ''
      options nvidia_drm fbdev=1 modeset=1
    '';
  };
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/b48e7966-0211-4185-9730-6e698a1f162d";
      fsType = "btrfs";
    };

    "/data" = {
      depends = [ "/" ];
      device = "/dev/disk/by-uuid/b48e7966-0211-4185-9730-6e698a1f162d";
      fsType = "btrfs";
      options = [
        "auto"
        "subvolid=267"
        "compress=zstd:1"
        "noatime"
        "exec"
      ];
    };

    "/data/db4" = {
      depends = [
        "/"
        "/data"
      ];
      device = "UUID=5CEC0131EC01074C";
      fsType = "ntfs";
      options = [
        "nofail"
        "users"
        "uid=1000"
        "gid=100"
        "auto"
        "umask=077"
        "exec"
        "permissions"
      ];
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/B40E-E974";
      fsType = "vfat";
    };

    "/home" = {
      device = "/dev/disk/by-uuid/b48e7966-0211-4185-9730-6e698a1f162d";
      fsType = "btrfs";
      options = [
        "subvolid=265"
        "compress=zstd:1"
      ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/b48e7966-0211-4185-9730-6e698a1f162d";
      fsType = "btrfs";
      options = [
        "subvolid=266"
        "compress=zstd:1"
        "noatime"
      ];
    };

    "tmp" = {
      device = "/dev/disk/by-uuid/b48e7966-0211-4185-9730-6e698a1f162d";
      fsType = "btrfs";
      options = [
        "subvolid=259"
        "compress=zstd:1"
        "noatime"
      ];
    };
  };

  networking = {
    hostName = "radio";
    networkmanager.enable = true;
    networkmanager.dns = "systemd-resolved";
    useDHCP = false;
    dhcpcd.enable = false;
    useNetworkd = false;

    interfaces.enp4s0 = {
      ipv6.addresses = [
        {
          address = "fd00:11a0:1309:1d84:4bba:3620:ebb1:0251";
          prefixLength = 64;
        }
      ];
      ipv4.addresses = [
        {
          address = "192.168.1.251";
          prefixLength = 24;
        }
      ];
    };

    defaultGateway = {
      address = "192.168.1.1";
      interface = "enp4s0";
    };
    defaultGateway6 = {
      address = "fd00:11a0:1309:1d84:4bba:3620:ebb1:01";
      interface = "enp4s0";
    };

    firewall.allowedTCPPorts = [
      22
      80
      443
      21
      20
      7711
      8384
    ];
  };
}
