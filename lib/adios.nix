{
  inputs,
  pkgs,
  adios,
  adios-wrappers,
}:
let
  root = {
    name = "executive";
    modules = pkgs.lib.recursiveUpdate adios-wrappers (adios.lib.importModules ../wrappers);
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
