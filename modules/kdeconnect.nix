{ config, lib, ... }:
let
  inherit (lib.options) mkEnableOption;
  inherit (config.destiny.flake.system) user;

  cfg = config.destiny.programs.kdeconnect;
in
{
  options.destiny.programs.kdeconnect = {
    enable = mkEnableOption "kdeconnect";
  };

  config = lib.modules.mkIf cfg.enable {
    programs.kdeconnect.enable = true;
    home-manager.users.${user} = {
      services.kdeconnect.enable = true;
    };
  };
}
