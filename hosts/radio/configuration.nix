{
  config,
  pkgs,
  lib,
  inputs,
  self,
  ...
}:
{
  # Lonely...!
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.substituters = lib.mkForce [
    "https://cache.nixos.org"
    "https://attic.xuyh0120.win/lantian"
    "https://cache.garnix.io"
  ];
  nix.settings.extra-substituters = [ "https://vicinae.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
    "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
  ];
  nix.settings.extra-trusted-public-keys = [
    "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
  ];

  system.modulesTree = [
    (lib.getOutput "modules" pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto.kernel)
  ];

  documentation = {
    enable = true;
    dev.enable = true;
    man.enable = true;
  };

  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    noto-fonts
    noto-fonts-color-emoji
  ];

  time.timeZone = "Asia/Singapore";

  environment = {
    variables = {
      __GL_THREADED_OPTIMIZATIONS = "0";
      EDITOR = "hx";
      VISUAL = "hx";
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      WEBKIT_DISABLE_DMABUF_RENDERER = 1;
    };

    systemPackages = import ./packages.nix { inherit inputs pkgs self; };
  };

  security = {
    polkit.enable = true;
    sudo = {
      enable = true;
      extraRules = [
        {
          commands = [
            {
              command = "${pkgs.systemd}/bin/systemctl suspend";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.systemd}/bin/reboot";
              options = [ "NOPASSWD" ];
            }
            {
              command = "${pkgs.systemd}/bin/poweroff";
              options = [ "NOPASSWD" ];
            }
          ];
          groups = [ "wheel" ];
        }
      ];

      extraConfig = with pkgs; ''
        Defaults:picloud secure_path="${
          lib.makeBinPath [
            systemd
          ]
        }:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin"
      '';
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
    permittedInsecurePackages = [ "olm-3.2.16" ];
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  systemd = {
    network = {
      enable = false;
      networks."main" = {
        matchConfig.Name = "enp4s0";
        networkConfig.DHCP = "ipv4";
      };
    };

    services."getty@tty1" = {
      overrideStrategy = "asDropin";
      serviceConfig.ExecStart = [
        ""
        "@${pkgs.util-linux}/sbin/agetty agetty -o '-p -- kami' --login-program ${config.services.getty.loginProgram}  --noclear --keep-baud %I 115200,38400,9600 $TERM"
      ];
    };

    # services."warp-daemon-server" = {
    #   enable = true;
    #   after = [ "network.target" ];
    #   wantedBy = [ "default.target" ];
    #   serviceConfig = {
    #     Type = "simple";
    #     ExecStart = "${pkgs.cloudflare-warp}/bin/warp-svc";
    #   };
    # };

  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };
  console = {
    keyMap = "us";
  };

  services = {
    xserver = {
      videoDrivers = [ "nvidia" ];
      xkb = {
        layout = "us";
      };
      displayManager = {
        lightdm.enable = false;
        startx.enable = false;
      };
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    openssh = {
      enable = true;
      ports = [ 7711 ];
      settings.PasswordAuthentication = true;
    };
    cloudflare-warp.enable = true;
    resolved = {
      enable = true;
      settings.Resolve = {
        Domains = ".";
        DNSOverTLS = false;
        DNSSEC = true;
        DNS = [
          "192.168.1.200"
          "fd00:11a0:1309:1d84:4bba:3620:ebb1:0200"
          # "2606:4700:4700::1111"
          # "1.1.1.1"
          # "1.0.0.1"
        ];
        FallbackDNS = [
          "fd00:11a0:1309:1d84:4bba:3620:ebb1:0200"
          "192.168.1.200"
          "2606:4700:4700::1111"
          "1.1.1.1"
          # "1.0.0.1"
        ];
        ResolveUnicastSingleLabel = true;
      };
    };
  };

  users.users.kami = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "kvm"
    ];
    shell = pkgs.bash;
  };

  destiny = {
    home-manager.enable = true;

    gtk = {
      enable = true;
    };
    programs = {
      alacritt.enable = true;
      fish.enable = true;
      rofi.enable = true;
      raycast.enable = true;
      steam.enable = true;
      xdg-portal.enable = true;
      niri = {
        enable = true;
        wallpaper = "girlWCigg.png";
        wallpaperSource = ../../assets/wallpapers;
      };
      helix.enable = true;
      zen.enable = true;
      bash = {
        enable = true;
        interactiveStart = ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi
        '';

        loginStart = ''
          if [ "$XDG_VTNR" -eq 1 ] && [ -z "$WAYLAND_DISPLAY" ]; then
              systemctl --user import-environment DISPLAY
              exec niri-session -l
          fi
        '';
      };
      wireshark.enable = true;
      vesktop.enable = true;
      xwayland = {
        enable = true;
        useSatellite = true;
      };
      # xwayland-satellite = { enable = true; };
    };
  };
}
