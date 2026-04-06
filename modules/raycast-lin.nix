{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.destiny.programs.raycast;
  inherit (lib.options) mkEnableOption;
  inherit (config.destiny.flake.system) user;
in
{
  options.destiny.programs.raycast = {
    enable = mkEnableOption "raycast";
  };

  config = lib.modules.mkIf cfg.enable {
    home-manager.users.${user} = {
      # imports = [ inputs.raycast-lin.homeManagerModules.default ];
      programs.vicinae = {
        # services.vicinae = {
        enable = true;
        systemd = {
          enable = true;
          autoStart = true;
          # target = "graphical.target";
          # environment.USE_LAYER_SHELL = 1;
        };
        settings = {
          close_on_focus_loss = true;
          consider_preedit = true;
          pop_to_root_on_close = true;
          favicon_service = "twenty";
          search_files_in_root = true;
          font = {
            normal = {
              size = 12;
              family = "Maple Nerd Font";
            };
          };
          theme = {
            light = {
              name = "ros";
              icon_theme = "default";
            };
            dark = {
              name = "tokyo-night";
              icon_theme = "default";
            };
          };
          launcher_window = {
            opacity = 0.98;
          };
        };
        extensions = with inputs.raycast-lin-ext.packages.${pkgs.stdenv.hostPlatform.system}; [
          nix
          awww-switcher
          fuzzy-files
          brotab
        ];
      };
    };
  };
}
