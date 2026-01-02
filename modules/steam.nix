{ config, lib, pkgs, ... }:
let
  inherit (lib.modules) mkIf;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib) types;

  cfg = config.destiny.programs.steam;
in {
  options.destiny.programs.steam = {
    enable = mkEnableOption "steam";

    remotePlay = mkOption {
      type = types.bool;
      description = "opens ports in the firewall for remote play";
      default = false;
    };
    localNetworkGameTransfers = mkOption {
      type = types.bool;
      description =
        "opens ports in the firewall for steam's local network game transfers";
      default = false;
    };
    dedicatedServers = mkOption {
      type = types.bool;
      description = "opens ports in the firewall for dedicated source servers";
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;

      remotePlay.openFirewall = cfg.remotePlay;
      dedicatedServer.openFirewall = cfg.dedicatedServers;
      localNetworkGameTransfers.openFirewall = cfg.localNetworkGameTransfers;
    };
  };
}
