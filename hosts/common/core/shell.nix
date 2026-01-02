{
  inputs,
  system,
  pkgs,
}:
let
  wrappers = inputs.self.packages.${system};
in
pkgs.mkShellNoCC {

  packages = [
    wrappers.git
  ];
}
