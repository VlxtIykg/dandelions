{ config, lib, ... }:
let
  inherit (lib.options) mkEnableOption;
  inherit (config.destiny.flake.system) user;

  cfg = config.destiny.gtk;
in {
  options.destiny.gtk = { enable = mkEnableOption "gtk"; };

  config = lib.modules.mkIf cfg.enable {
    home-manager.users.${user} = { gtk = { enable = true; }; };
  };
}

