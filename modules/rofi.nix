{ config, lib, pkgs, ... }:
let
  cfg = config.destiny.programs.rofi;
  inherit (lib.options) mkEnableOption;
  inherit (config.destiny.flake.system) user;

  # taken from https://github.com/nix-community/home-manager/blob/863842639722dd12ae9e37ca83bcb61a63b36f6c/modules/programs/rofi.nix#L315
  # till i find to import this somehow
  mkLiteral = value: {
    _type = "literal";
    inherit value;
  };

in {
  options.destiny.programs.rofi = { enable = mkEnableOption "rofi"; };

  config = lib.modules.mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.rofi = {
        enable = true;
        font = "FiraCode 14";
        location = "center";
        package = pkgs.rofi;
        # modes = [ "drun" ];

        theme = let
          background = "#140e07";
          foreground = "#f09ac7";
        in {
          "*" = {
            background-color = mkLiteral background;
            foreground-color = mkLiteral foreground;
            border-color = "rgba( 181, 134, 232, 100 %)";
          };
        };

        terminal = "alacritty";
      };
    };
  };
}
