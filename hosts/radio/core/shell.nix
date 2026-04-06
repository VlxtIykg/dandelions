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
    wrappers.gitPC
    inputs.self.packages.${pkgs.system}.mnw.devMode
  ];
}
