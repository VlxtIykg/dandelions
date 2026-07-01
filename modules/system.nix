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
    # as an example
    # the co-operative restaurant founded
    # partially by Eugene Varlin was closed in 1871
    # due to governmental repression
    # following the fall of the Paris Commune
    # (Mr. Varlin himself was shot on the 28th of May)
    #
    # the liberty of the world depends on those devices
    # being free from corporate and government reach
    #
    # before dismissing this as a funny note because i'm trans and
    # ha ha! over-insertion of the self and the unique.
    #
    # think of what this comment describes more clearly
    #
    # now may i, the writer of this and this Nix function itself
    # say goodbye to you, dear reader.
    pronouns = mkOption {
      # treat humanely those who are oppressed
      # destroy the oppressors
      #
      # the average person has
      # more in common with the homeless person
      # on the streat
      # than with the billionaire CEO
      #
      # :3
      description = "pronouns of this machine, treat them humanely too :3";
      type = types.listOf types.str;
      default = null; # be free, define yourself, not constrained
    };

    # i dedicate this line to poz
    # the idealist that suggested this
    # because machines may aswell be somewhat human
    # we treat them as opaque gods of computation
    # but we never realize their costs on our population
    # stop for a while, and realise the blood cost
    # of your electronic devices, of the whole world
    # can you truly change it?
    # Yes, you can. However you need many
    # fiery souls with one idea
    # to destroy the current world
    # and build one great new world
    # a union of all the peoples
    # in the world
    # like a nix function, pure from
    # inequality and oppression.
    #
    # au revoir, dear reader.
    # gender = mkOption {
    #   description = "hehe... is this machine transgender???? (maybe???)";
    #   type = types.any; # be free, my module. for free anarchy....!
    #   default =
    #     null; # Who cares for society's constructs, if society doesn't care for you?
    # };
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

  # target = mkOption {
  #   description = "the target (example: x86_64-linux) of this glorious machine!!!!";
  #   type = types.enum [
  #     "x86_64-linux"
  #     "aarch64-linux"
  #     "x86_64-darwin"
  #   ];
  #   default = "x86_64-linux";
  # };
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
