{ config, pkgs, lib, ... }:
let
  cfg = config.destiny.programs.xwayland-satellite;
  inherit (lib.options) mkEnableOption;
  inherit (config.destiny.flake.system) user;
in {
  options.destiny.programs.xwayland-satellite = {
    enable = mkEnableOption "xwayland-satellite";

  };

  config = lib.modules.mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.xwayland-satellite = { enable = true; };
    };
  };

}
