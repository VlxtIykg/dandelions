{ adios }:
let
  inherit (adios) types;
in
{
  name = "git";

  inputs = {
    nixpkgs.path = "/nixpkgs";
    # config.path = "/config";
  };

  options = {
    ignoreFile = {
      type = types.path;
      default = ./meowEat;
    };

    name = {
      description = "Gives the user.name in your git config";
      type = types.str;
      default = "Kami";
    };

    email = {
      description = "Gives the user.email in your git config";
      type = types.str;
      default = "me@kami.wtf";
    };

    gitSettingPath = {
      description = "";
      type = types.path;
      default = ./gitSettings.nix;
    };

    iniConfig = {
      type = types.attrs;
      defaultFunc =
        {
          options,
        }:
        import options.gitSettingPath { inherit options; };
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
            name = "git/ignore";
            path = options.ignoreFile;
          }
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
      name = "gift";
      paths = [
        pkgs.git
        options.configDirectory
      ];
      nativeBuildInputs = [
        makeWrapper
      ];
      # buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/git \
          --set XDG_CONFIG_HOME $out
      '';
      meta.mainProgram = "git";
    };
}
