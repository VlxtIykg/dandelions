{
  inputs,
  pkgs,
  adios,
}:
let
  root = {
    name = "executive";
    modules = adios.lib.importModules ../wrappers;
    # This imports ../wrappers/git.nix, ../wrappers/nixpkgs.nix
    # modules = {
    # import ./wrappers/git.nix { inherit pkgs adios; };
    # }
  };

  yggdrasil = (adios root).eval {
    options = {
      "/nixpkgs" = {
        inherit pkgs;
      };
    };
  };
in

yggdrasil.root.modules
