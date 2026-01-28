{ adios }:
let
  inherit (adios) types;
in
{
  name = "ungoogled-chromium";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    # config.path = "/config";
  };

  options = {

    ungooglSettingPath = {
      description = "";
      type = types.path;
      default = ./ungooglifyConfig.nix;
    };

    iniConfig = {
      type = types.attrs;
      defaultFunc =
        {
          options,
        }:
        import options.ungooglSettingPath { inherit options; };
    };

    configDirectory = {
      type = types.derivation;
      defaultFunc =
        { options, inputs }:
        let
          inherit (inputs.nixpkgs) pkgs lib;

          inherit (pkgs) linkFarm writeText;
          inherit (lib.generators) toGitINI;
        in
        linkFarm "gitconfig" [
          {
            name = "git/config";
            path = writeText "config" (toGitINI options.iniConfig);
          }
        ];
    };
  };

  impl =
    { options, inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
      inherit (pkgs) symlinkJoin makeWrapper;
    in
    symlinkJoin {
      name = "ungoogled-chromium";
      paths = [
        pkgs.ungoogled-chromium
        # options.configDirectory
      ];
      nativeBuildInputs = [
        makeWrapper
      ];
      # buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/chromium
      '';
      meta.mainProgram = "chromium";
    };
}
