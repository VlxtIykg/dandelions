{
  inputs,
  config,
  lib,
  ...
}:
let
  cfg = config.destiny.programs.zen;
  inherit (lib.options) mkEnableOption;
  inherit (config.destiny.flake.system) user;
in
{
  options.destiny.programs.zen = {
    enable = mkEnableOption "zen";
  };

  config = lib.modules.mkIf cfg.enable {
    home-manager.users.${user} = {
      imports = [ inputs.zen-browser.homeModules.beta ];
      programs.zen-browser.enable = true;
      programs.zen-browser.policies =
        let
          mkLockedAttrs = builtins.mapAttrs (
            _: value: {
              Value = value;
              Status = "locked";
            }
          );
        in
        {
          AutofillAddressEnabled = false;
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxAccounts = true;
          DisableFirefoxStudies = true;
          DisableMasterPasswordCreation = true;
          DisableSetDesktopBackground = true;
          DisableBookmarksToolbar = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          OfferToSaveLogins = false;
          FirefoxSuggest.WebSuggestions = false;
          FirefoxSuggest.SponsoredSuggestions = false;
          FirefoxSuggest.ImproveSuggest = false;
          FirefoxSuggest.Locked = true;
          GenerativeAI.Enabled = false;
          GenerativeAI.Locked = true;
          HttpsOnlyMode = "forced_enabled";
          NoDefaultBookmarks = true;
          Preferences = mkLockedAttrs {
            "browser.aboutConfig.showWarning" = false;
            "browser.ml.chat.enabled" = false;
            "browser.ml.chat.menu" = false;
            "browser.ml.linkPreview.enabled" = false;
            "pdfjs.enableAltText" = false;
            "extensions.ml.enable" = false;
            "browser.ml.enabled" = false;
            "security.insecure_connection_text.enabled" = true;
            "security.insecure_connection_text.pbmode.enabled" = true;
            "security.ssl.errorReporting.enabled" = false;
          };
        };
    };
  };
}
