{ config, lib, ... }:
let
  inherit (lib.options) mkEnableOption;
  inherit (config.destiny.flake.system) user;

  cfg = config.destiny.programs.something;
in
{
  options.destiny.programs.something = {
    enable = mkEnableOption "something";
  };

  config = lib.modules.mkIf cfg.enable {
    home-manager.users.${user} = {
      services.syncthing = {
        enable = true;
        # openDefaultPorts = true; only for nixos module
        guiAddress = "192.168.1.251:3354";
        settings.gui.user = "juli";
        settings.gui.password = "julienne";
        settings.devices."Main Brain".id =
          "F7GAQ2H-2FQ5WG7-LRNB2PV-URYRAZB-A43KINR-UAHFCI5-AIH6S5U-OJ7IXAQ"; # conglomerate
        settings.devices."Hyper Vision".id =
          "PWRX5KJ-736EJ5A-WBEUFNM-RRMRA5W-7CBPJEX-MDPJR7S-JD3GC2E-FJNBGAV"; # ProxyMax
        settings.devices."Mobile Archer".id =
          "JA5D2CF-ATWIFIX-FKEKGLC-4NCUWYO-V3XQ6HK-4OZN3VT-7QVKRII-OY2KUQC"; # Arch Untrusted (Leaves network)
        settings.folders = {
          "Work" = {
            id = "qroau-axfg7";
            path = "/data/syncthing/work";
            label = "Work";
            devices = [
              "Main Brain"
              "Hyper Vision"
              "Mobile Archer"
            ];
          };
          "TD" = {
            id = "6zwky-gbdqi";
            ignorePatterns = [ "lost+found" ];
            path = "/data/syncthing/thumbdrives";
            label = "TD";
            devices = [
              "Main Brain"
              "Hyper Vision"
            ];
          };
          "Personal" = {
            id = "5o5we-fnjf3";
            path = "/data/syncthing/Personal";
            label = "Personal";
            devices = [
              "Main Brain"
              "Hyper Vision"
            ];
          };
          "Studious" = {
            id = "tdpyj-5nppj";
            path = "/data/syncthing/Research";
            label = "Studies";
            devices = [
              "Main Brain"
              "Hyper Vision"
            ];
          };
          "Nature" = {
            id = "mlpsy-k7grp";
            path = "/data/syncthing/Nature";
            label = "Nature";
            devices = [
              "Main Brain"
              "Hyper Vision"
            ];
          };
        };
      };
    };
  };
}
