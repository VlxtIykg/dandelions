{ config, lib, ... }:
let
  inherit (lib.destiny) colorPicker colorScheme;
  inherit (lib.options) mkEnableOption;
  inherit (config.destiny.flake.system) user;

  cfg = config.destiny.programs.alacritt;
in
{
  options.destiny.programs.alacritt = {
    enable = mkEnableOption "alacritt";
  };

  config = lib.modules.mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.alacritty = {
        enable = true;
        settings = {

          window = {
            padding = rec {
              x = 5;
              y = x;
            };
          };

          colors = {
            primary = {
              background = colorScheme.bg;
              foreground = colorScheme.fg;
            };

            normal = {
              black = colorPicker 1;
              blue = colorPicker 1;
              cyan = colorPicker 2;
              green = colorPicker 3;
              magenta = colorPicker 4;
              red = colorPicker 5;
              white = colorPicker 6;
              yellow = colorPicker 7;
            };
          };

          font = {
            size = 12.0;
            bold = {
              family = "Fira Code";
              style = "Bold";
            };

            italic = {
              family = "Fira Code";
              style = "Italic";
            };

            normal = {
              family = "Fira Code";
              style = "Retina";
            };
          };
        };
      };
    };
  };
}
