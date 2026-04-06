{ config, users, pkgs, lib, ... }:
let
  cfg = config.destiny.programs.wireshark;
  inherit (lib) types;
  inherit (config.destiny.flake.system) user;
  inherit (lib.options) mkEnableOption mkOption;
in {
  options.destiny.programs.wireshark = {
    enable = mkEnableOption "wireshark";

    captureUsb = mkOption {
      default = false;
      type = types.bool;
      description = "If users should be able to capture usb traffic";
    };

    package = mkOption {
      default = pkgs.wireshark; # gui cause i suck
      type = types.package;
      description = "The package of wireshark to use";
    };
  };

  config = lib.modules.mkIf cfg.enable {
    programs.wireshark = {
      enable = true;

      package = cfg.package;
      usbmon.enable = cfg.captureUsb;
      dumpcap.enable = true;
    };

    users.users.${user}.extraGroups = [ "wireshark" ];
  };
}
