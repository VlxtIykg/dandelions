{ config, lib, ... }:
let
  cfg = config.destiny.programs.bash;
  inherit (lib.options) mkEnableOption mkOption;
  inherit (lib) types;
in
{
  options.destiny.programs.bash = {
    enable = mkEnableOption "bash";

    interactiveStart = mkOption {
      type = types.str;
      default = "";
      description = "command ran at the start of an interactive bash session";
    };

    loginStart = mkOption {
      type = types.str;
      default = "";
      description = "command ran at the start of a login bash session";
    };

  };

  config = {
    programs.bash = {
      interactiveShellInit = cfg.interactiveStart;
      loginShellInit = cfg.loginStart;
    };
  };
}
