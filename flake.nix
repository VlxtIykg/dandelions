{
  description = "Reincarnation";

  inputs = {
  };
  outputs =
    inputs@{
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      systems = [ "x86_64-linux" ]; # all i got :)
      forAllSystems =
        apply: lib.genAttrs systems (system: apply inputs.nixpkgs.legacyPackages.${system} system);

    in
    {
    };

}
