{ config, lib, ... }:
let
  inherit (lib.destiny) colorScheme;
  inherit (lib.options) mkEnableOption;
  inherit (config.destiny.flake.system) user;

  colors = lib.destiny.colorScheme;
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
              black = colors.black;
              blue = colors.blue;
              cyan = colors.blue;
              green = colors.green;
              magenta = colors.orange;
              red = colors.red;
              white = colors.fg;
              yellow = colors.yellow;
            };
          };

          font = {
            size = 12.65;
            bold = {
              family = "MonaspiceNe NF";
              style = "Bold";
            };

            italic = {
              family = "MonaspiceNe NF";
              style = "Italic";
            };

            normal = {
              family = "MonaspiceNe NF";
              style = "Retina";
            };
          };
        };
      };
    };
  };
}
