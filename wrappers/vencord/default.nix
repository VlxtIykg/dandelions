{ adios }:
let
in
{
  name = "vencord";

  inputs = {
    nixpkgs.path = "/nixpkgs";
  };

  impl =
    { inputs }:
    let
      inherit (inputs.nixpkgs) pkgs;
      inherit (pkgs) symlinkJoin makeWrapper;
      version = "1.14.1";
      src = pkgs.fetchFromGithub {
        owner = "Vendicated";
        repo = "Vencord";
        rev = "v${version}";
        hash = "sha256-g+zyq4KvLhn1aeziTwh3xSYvzzB8FwoxxR13mbivyh4=";
      };
    in
    symlinkJoin {
      name = "vencord";
      paths = [
        src
      ];
      nativeBuildInputs = [
        makeWrapper
      ];
      # buildInputs = [ makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/vencord 
      '';
      meta.mainProgram = "vencord";
    };
}
