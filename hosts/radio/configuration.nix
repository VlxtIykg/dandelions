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

  system.modulesTree = [ (lib.getOutput "modules" pkgs.linuxPackages_cachyos-lto.kernel) ];

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

  security.polkit.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };

  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };

  systemd = {
    network = {
      enable = true;
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
  };

  users.users.kami = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
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
      steam.enable = true;
      xdg-portal.enable = true;
      niri = {
        enable = true;
        wallpaper = "Fantasy-Autumn.png";
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
