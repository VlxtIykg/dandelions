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
      # open = true;
      open = false;
      nvidiaSettings = true;
      # package = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3.nvidiaPackages.beta;
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
          # Shows battery charge of connected devices on supported
          # Bluetooth adapters. Defaults to 'false'.
          Experimental = true;
          # When enabled other devices can connect faster to us, however
          # the tradeoff is increased power consumption. Defaults to
          # 'false'.
          FastConnectable = true;
        };
        Policy = {
          # Enable all controllers when they are found. This includes
          # adapters present on start as well as adapters that are plugged
          # in later on. Defaults to 'true'.
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
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/astronaut2.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/astronaut_jellyfish.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/black-whole2.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/black-whole.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/car_on_mars.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/dark-waves.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/depechemode-violator.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/emergence.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/escape_velocity.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/explorer_orange_sunset.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/Fantasy-Autumn.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/Fantasy-Landscape3.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/fantasy-mountain1.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/fantasy-mountain2.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/fantasy-mountain3.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/forest-landscape.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/ireland-hills.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/italy.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/landscape-abstract-neon.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/landscape.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/marina-bay-sands.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/midnight-reflections-moonlit-sea.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/moonlight.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/mountain-lake.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/mountain-snow-minima.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/mountain-sunrise.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/muscle-car-ice-road-red-moon.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/mystical-night-in-town.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/nature.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/neon_car.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/night_city.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/Nocturne-of-Steel-and-Glass.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/nordwall3.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/raw-expression.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/river_to_castle_theme_blue.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/rocket_launch.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/scary_cat.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/snowy-peace.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/Solitary-Glow.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/sunset-01.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/sunset-10.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/sunset-drive-forest.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/sunset-in-thick-forest.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/sunset-lookout.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/sunset-mountain-beautiful.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/sunset-scenery-minimalist.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/tron-ares.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/tron_legacy1.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/tron_legacy2.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/tron_legacy4.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/tron_legacy6.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/vintage-ascent.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/vulcan.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/wallhaven1.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/wallhaven3.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/wallhaven4.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/watchtower-mountains-and-forests.jpeg
    # wallpaper: guid(b48e7966-0211-4185-9730-6e698a1f162d):/var/wallpaper/winter-is-here.jpeg

    extraModprobeConfig = ''
      options nvidia_drm fbdev=1 modeset=1
    '';
  };

  # networking refer below for networking;
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

    # "/data/db5" = {
    #   depends = [
    #     "/"
    #     "/data"
    #   ];
    #   device = "UUID=01D9485C05AF0E90";
    #   fsType = "ntfs";
    #   options = [
    #     "nofail"
    #     "users"
    #     "uid=1000"
    #     "gid=100"
    #     "auto"
    #     "umask=077"
    #     "exec"
    #     "permissions"
    #   ];
    # };

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
      # ipv6.addresses = [
      #   {
      #     address = "fd00:11a0:1309:1d84:4bba:3620:ebb1:0251";
      #     prefixLength = 64;
      #   }
      # ];
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
    # defaultGateway6 = {
    #   address = "fd00:11a0:1309:1d84:4bba:3620:ebb1:01";
    #   interface = "enp4s0";
    # };

    # nameservers = [
    # "127.0.2.2"
    # "127.0.2.3"
    # "fd00:11a0:1309:1d84:4bba:3620:ebb1:0200"
    # "192.168.1.200"
    # "2606:4700:4700::1111"
    #   "1.1.1.1"
    #   "1.0.0.1"
    # ];
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
