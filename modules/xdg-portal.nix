{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.destiny.programs.xdg-portal;
  inherit (lib.options) mkEnableOption;
in
{
  options.destiny.programs.xdg-portal = {
    enable = mkEnableOption "xdg-portal";
  };

  config = lib.modules.mkIf cfg.enable {
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
          # xdg-desktop-portal-gtk
          xdg-desktop-portal
          xdg-desktop-portal-wlr
        ];
        wlr.enable = true;
        config = {
          niri = {
            default = [ "wlr" ];
            "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
            "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
          };
          common.default = "*";
        };
      };
    };
  };
}
