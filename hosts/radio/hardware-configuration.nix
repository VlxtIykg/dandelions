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
        extraEntries = ''
          /Gaming (win-x86_64)
            protocol: efi
            path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
            comment: Yes
        '';
        extraConfig = ''
          "$\{resource_arg}=nixos"
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
          wallpaper: fslabel(nixos):../..//var/wallpaper/astronaut2.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/astronaut_jellyfish.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/black-whole2.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/black-whole.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/car_on_mars.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/dark-waves.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/depechemode-violator.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/emergence.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/escape_velocity.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/explorer_orange_sunset.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/Fantasy-Autumn.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/Fantasy-Landscape3.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/fantasy-mountain1.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/fantasy-mountain2.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/fantasy-mountain3.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/forest-landscape.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/ireland-hills.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/italy.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/landscape-abstract-neon.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/landscape.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/marina-bay-sands.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/midnight-reflections-moonlit-sea.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/moonlight.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/mountain-lake.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/mountain-snow-minima.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/mountain-sunrise.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/muscle-car-ice-road-red-moon.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/mystical-night-in-town.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/nature.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/neon_car.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/night_city.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/Nocturne-of-Steel-and-Glass.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/nordwall3.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/raw-expression.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/river_to_castle_theme_blue.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/rocket_launch.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/scary_cat.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/snowy-peace.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/Solitary-Glow.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/sunset-01.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/sunset-10.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/sunset-drive-forest.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/sunset-in-thick-forest.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/sunset-lookout.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/sunset-mountain-beautiful.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/sunset-scenery-minimalist.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/tron-ares.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/tron_legacy1.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/tron_legacy2.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/tron_legacy4.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/tron_legacy6.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/vintage-ascent.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/vulcan.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/wallhaven1.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/wallhaven3.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/wallhaven4.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/watchtower-mountains-and-forests.jpeg
          wallpaper: fslabel(nixos):../..//var/wallpaper/winter-is-here.jpeg
        '';
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
    "/data/db4" = {
      device = "UUID=5CEC0131EC01074C";
      fsType = "ntfs";
      options = [
        "users"
        "nofail"
        "uid=1000"
        "gid=100"
        "auto"
        "umask=077"
        "exec"
        "permissions"
      ];
    };

    "/data/db5" = {
      device = "UUID=01D9485C05AF0E90";
      fsType = "ntfs";
      options = [
        "users"
        "nofail"
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
    firewall.allowedTCPPorts = [
      22
      80
      443
      21
      20
      7711
    ];

  };

}
