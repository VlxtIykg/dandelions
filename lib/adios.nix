{
  inputs,
  pkgs,
  adios,
  adios-wrappers,
}:
let
  inherit (builtins) mapAttrs;
  root = {
    name = "executive";
    modules = pkgs.lib.recursiveUpdate adios-wrappers (adios.lib.importModules ../wrappers);

    # modules = adios.lib.importModules ../wrappers;
    # This imports ../wrappers/git.nix, ../wrappers/nixpkgs.nix
    # modules = {
    # import ./wrappers/git.nix { inherit pkgs adios; };
    # }
  };

  yggdrasil = adios root {
    options = {
      "/nixpkgs" = {
        inherit pkgs;
        inherit (pkgs) lib;
      };
    };
  };

in
builtins.mapAttrs (
  _: wrapper:
  if wrapper.args.options ? __functor then
    (removeAttrs wrapper.args.options [ "__functor" ]) // { drv = wrapper { }; }
  else
    wrapper.args.options
) yggdrasil.modules
