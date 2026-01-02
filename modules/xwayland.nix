{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.destiny.programs.xwayland;
  inherit (lib) types;
  inherit (lib.options) mkEnableOption mkOption;
in
{
  options.destiny.programs.xwayland = {
    enable = mkEnableOption "xwayland";

    useSatellite = mkOption {
      type = types.bool;
      default = false;
      description = "This quote-unquote invitare the package into the environment (aka install to system).";
    };
  };

  config = lib.modules.mkIf cfg.enable {
    programs.xwayland = {
      enable = true;
    };

    environment.systemPackages = [ ] ++ lib.optional cfg.useSatellite pkgs.xwayland-satellite;
  };
}
