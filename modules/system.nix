# describes the environment

{ config, lib, ... }:
let
  inherit (lib) types;
  inherit (lib.options) mkOption;

  cfg = config.destiny.flake.system;
in
{
  options.destiny.flake.system = {
    host = mkOption {
      description = "hostname for this pawsome device :3";
      type = types.str;
      default = "radio";
    };

    user = mkOption {
      description = "the master of this pawwsome device :3";
      type = types.str;
      default = "kami";
    };

    target = mkOption {
      description = "the target (example: x86_64-linux) of this glorious machine!!!!";
      type = types.enum [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
      ];
      default = "x86_64-linux";
    };

    # it seems silly to assign pronouns to this mere machine
    # but think how much you interact with them
    # don't they resemble somewhat of a person
    # with their error codes, error messages and delightful successes
    # they're somewhat of a gateway to another world
    # how would i meet the person mentioned below
    # with this marvel of engineering
    # but also that comes at a cost
    # it is *privilege* to use this machine currently
    # think of the rest of the earth with no access to it
    # or very limited one at best
    # it is not only a tool of entertainment
    # but also of a new age of bypassing governments
    # where in 1878 a newspaper could get simply closed down
    #
    pronouns = mkOption {
      description = "pronouns of this machine, treat them humanely too :3";
      type = types.listOf types.str;
      default = null; # be free, define yourself, not constrained
    };
    # au revoir, dear reader.
    gender = {
      zodiac = mkOption {
        type = types.enum [
          "aries"
          "taurus"
          "gemini"
          "cancer"
          "leo"
          "virgo"
          "libra"
          "scorpio"
          "sagittarius"
          "capricorn"
          "aquarius"
          "pisces"
        ];
        default = "scorpio";
        description = "Machines has zodiac signs??";
      };
      queen = mkOption {
        type = types.int;
        default = 0;
        description = "The machine is a queen?????";
      };
    };
  };

  config = {
    networking.hostName = cfg.host;
    users.users.${cfg.user} = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "audio"
      ];
    };
  };
}
