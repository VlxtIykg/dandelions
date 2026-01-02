{ inputs, config, lib, ... }:
let
  cfg = config.destiny.programs.zen;
  inherit (lib.options) mkEnableOption;
  inherit (config.destiny.flake.system) user;
in {
  options.destiny.programs.zen = { enable = mkEnableOption "zen"; };

  config = lib.modules.mkIf cfg.enable {
    home-manager.users.${user} = {
      imports = [ inputs.zen-browser.homeModules.beta ];
      programs.zen-browser.enable = true;
      programs.zen-browser.policies = let
        mkLockedAttrs = builtins.mapAttrs (_: value: {
          Value = value;
          Status = "locked";
        });
      in {
        DisableAppUpdate = false;
        DisableFeedbackCommands = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisableMasterPasswordCreation = true;
        DisableSetDesktopBackground = true;
        DisableBookmarksToolbar = true;
        DontCheckDefaultBrowser = true;
        FirefoxSuggest.WebSuggestions = false;
        FirefoxSuggest.SponsoredSuggestions = false;
        FirefoxSuggest.ImproveSuggest = false;
        FirefoxSuggest.Locked = true;
        GenerativeAI.Enabled = false;
        GenerativeAI.Locked = true;
        HttpsOnlyMode = "forced_enabled";
        NoDefaultBookmarks = true;
        Preferences =
          mkLockedAttrs { "browser.aboutConfig.showWarning" = false; };
      };
    };
  };
}
