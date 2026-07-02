{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cfg = config.destiny.programs.niri;
  # cfgXwayland = config.destiny.programs.xwayland.useSatellite;

  inherit (config.destiny.flake.system) user;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib) types attrNames;
  inherit (config.home-manager.users.${user}.lib) niri;

  pathToWallpaper = "${cfg.wallpaperSource}/${cfg.wallpaper}";

in
{
  options.destiny.programs.niri = {
    enable = mkEnableOption "niri";

    wallpaperSource = mkOption {
      description = "directory containing wallpapers";
      type = types.path;
      default = ../assets/wallpapers;
    };

    wallpaper = mkOption {
      description = "file name of the wallpaper image located in assets/wallpapers/";
      type = types.enum (attrNames (builtins.readDir cfg.wallpaperSource)); # fancy schamncy way of populating enum in nix
      default = "moonlight.png";
    };
  };

  imports = [ inputs.niri.nixosModules.niri ];

  config = lib.modules.mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.niri.overlays.niri ];

    programs.niri = {
      # enable = false;
      enable = true;
      package = pkgs.niri-unstable;
      # package = pkgs.niri-stable;
      # niri-flake.cache.enable = false;
    };

    home-manager.users.${user} = {
      programs.niri = with niri.actions; {
        package = pkgs.niri-unstable;
        # package = pkgs.niri-stable;
        settings = {
          input.keyboard = {
            xkb = {
              layout = "us";
            };
            numlock = true;
          };

          input.workspace-auto-back-and-forth = true;
          input.mouse.scroll-method = "on-button-down";
          # input.mouse.scroll-button-lock = true;
          # input.focus-follows-mouse.enable = true;
          input.warp-mouse-to-focus = {
            enable = true;
            mode = "center-xy";
          };
          clipboard.disable-primary = true;

          spawn-at-startup = [
            { command = [ "zen-beta" ]; }
            {
              command = [
                "swaybg"
                "-i"
                pathToWallpaper
              ];
            }
          ];
          # ] ++ lib.optional cfgXwayland {
          # command = [ "xwayland-satellite" "&" ];
          # };

          prefer-no-csd = true;
          layout = {
            focus-ring = {
              active.color = "rgb(181 134 232)";
              width = 5;
            };
            shadow.enable = true;
          };
          window-rules = [
            {
              matches = [
                {
                  app-id = "^Alacritty$";
                }
              ];
              focus-ring = {
                enable = false;
                width = 10000;
                active.color = "#00000055";
              };
              border = {
                enable = true;
                width = 4;
              };
              # background-effect = {
              #   blur = true;
              # };

            }
            {
              matches = [ { title = "Bitwarden — Zen Browser$"; } ];
              open-floating = true;
            }
            {
              matches = [ { title = "Dunst"; } ];
              open-floating = true;

              focus-ring = {
                enable = true;
                active.color = "#f38ba8";
                inactive.color = "#7d0d2d";
              };
              border = {
                enable = true;
                inactive.color = "#7d0d2d";
              };

            }
            {
              matches = [
                {
                  app-id = "vesktop";
                }
              ];
              open-floating = false;

              focus-ring = {
                enable = true;
                active.color = "#f38ba8";
                inactive.color = "#7d0d2d";
              };
              # border = {
              #   enable = true;
              #   inactive.color = "#7d0d2d";
              # };
              # shadow = {
              #   enable = true;
              #   color = "#7d0d2d70";
              # };
              # tab-indicator = {
              #   active.color = "#f38ba8";
              #   inactive.color = "#7d0d2d";
              # };
              block-out-from = "screencast";
            }
            {
              matches = [ { is-window-cast-target = true; } ];

              # The themes are set for vesktop because currently I cannot choose the application to be casted!
              focus-ring = {
                enable = true;
                active.color = "#f38ba8";
                inactive.color = "#7d0d2d";
              };
              # border = {
              #   enable = true;
              #   inactive.color = "#7d0d2d";
              # };
              shadow = {
                enable = true;
                color = "#7d0d2d70";
              };
              tab-indicator = {
                active.color = "#f38ba8";
                inactive.color = "#7d0d2d";
              };
            }
          ];

          binds = {
            "Alt+Q".action = spawn "alacritty";
            "Alt+Shift+D".action = spawn "vicinae" "toggle";
            "Alt+Shift+Z".action = spawn "vicinae" "close";
            "Alt+Shift+X".action = spawn "vicinae" "open";
            # "Alt+D".action = spawn "rofi" "-show" "drun";
            "Alt+Shift+F".action = spawn "zen-beta";
            # "Alt+G".action = spawn "firefox";
            "Alt+C".action = close-window;

            "Alt+S".action.screenshot = [ ];
            "Print".action.screenshot-screen = [ ];
            "Alt+Print".action.screenshot-window = [ ];
            "Alt+Shift+B".action = fullscreen-window;
            "Alt+Shift+M".action = maximize-window-to-edges;
            "Alt+Shift+N".action = maximize-column;

            "Alt+Shift+W".action = move-window-up;
            "Alt+Shift+S".action = move-window-down;

            "Alt+W".action = move-column-left;
            "Alt+A".action = move-column-right;

            "Alt+E".action = focus-column-left;
            "Alt+R".action = focus-column-right;

            "Alt+Shift+E".action = focus-monitor-left;
            "Alt+Shift+R".action = focus-monitor-right;

            "Alt+Shift+Left".action = set-column-width "+10%";
            "Alt+Shift+Right".action = set-column-width "-10%";
            "Alt+Shift+Up".action = set-window-height "+10%";
            "Alt+Shift+Down".action = set-window-height "-10%";

            "Alt+J".action = move-column-to-workspace-up;
            "Alt+K".action = move-column-to-workspace-down;
            "Alt+H".action = move-column-to-monitor-left;
            "Alt+L".action = move-column-to-monitor-right;

            "Alt+Shift+T".action = toggle-window-floating;

            "XF86AudioRaiseVolume".action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.05+"
            ];
            "XF86AudioLowerVolume".action.spawn = [
              "wpctl"
              "set-volume"
              "@DEFAULT_AUDIO_SINK@"
              "0.05-"
            ];
            "XF86AudioMute".action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SINK@"
              "toggle"
            ];
            "Alt+XF86AudioMute".action.spawn = [
              "wpctl"
              "set-mute"
              "@DEFAULT_AUDIO_SOURCE@"
              "toggle"
            ];

            "Ctrl+XF86AudioRaiseVolume".action.spawn = [
              "pactl"
              "set-sink-volume"
              "bluez_output.30_53_C1_4D_CA_AC.1"
              "+5%"
            ];
            "Ctrl+XF86AudioLowerVolume".action.spawn = [
              "pactl"
              "set-sink-volume"
              "bluez_output.30_53_C1_4D_CA_AC.1"
              "-5%"
            ];
            "Ctrl+XF86AudioMute".action.spawn = [
              "pactl"
              "set-sink-mute"
              "bluez_output.30_53_C1_4D_CA_AC.1"
              "toggle"
            ];
            "alt+ctrl+xf86audiomute".action.spawn = [
              "pactl"
              "set-source-mute"
              "bluez_input.30:53:C1:4D:CA:AC"
              "toggle"
            ];

            # workspace keybinds
          }
          // builtins.listToAttrs (
            builtins.map (x: {
              name = "Alt+${toString x}";
              value = {
                action = focus-workspace x;
              };
            }) (builtins.genList (x: x + 1) 9)
          );

          # column keybinds
          # // builtins.listToAttrs (builtins.map (x: {
          #   name = "Alt+Shift+${toString x}";
          #   value = { action = move-column-to-workspace x; };
          # }) (builtins.genList (x: x + 1) 9));
          animations = {
            config-notification-open-close.kind = {
              easing.curve = "ease-out-quad";
              easing.duration-ms = 2500;
            };
            window-close.kind = {
              easing.curve = "ease-out-cubic";
              easing.duration-ms = 600;
            };
            workspace-switch.kind = {
              easing.curve = "ease-out-expo";
              easing.duration-ms = 500;
            };
          };

          # cursor.theme = "Reisen";
          cursor.theme = "YuzuhaBLZ";
          # cursor.theme = "FrierenBLZ";
          # cursor.theme = "FernBLZ";
          # cursor.theme = "Win7Bulid-cursors";
          cursor.hide-when-typing = true;
          cursor.size = 60;

          outputs = {
            "HDMI-A-1" = {
              position = {
                x = 1920;
                y = 0;
              };
              mode = # Sets the resolution and refresh rate
                {
                  width = 1920;
                  height = 1080;
                  refresh = 144.001;
                };
            };
            "DP-1" = {
              position = {
                x = 0;
                y = 0;
              };
              mode = # Sets the resolution and refresh rate
                {
                  width = 1920;
                  height = 1080;
                  refresh = 180.003;
                };
              # variable-refresh-rate = true;
            };
          };
        };
      };
    };
  };
}
