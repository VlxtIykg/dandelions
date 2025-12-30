{
  description = "Reincarnation";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs.url = "nixpkgs/nixos-25.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    niri.url = "github:sodiboo/niri-flake";
  };
  outputs =
    inputs@{
      nixpkgs,
      chaotic,
      ...
    }:
    let
      system = "x86_64-linux";
      lib = import ./lib/default.nix nixpkgs.lib;
      nixosConfigurations = import ./hosts {
        inherit
          lib
          inputs
          chaotic
          pkgs
          ;
      };

      systems = [ "x86_64-linux" ]; # all i got :)
      forAllSystems =
        apply: lib.genAttrs systems (system: apply inputs.nixpkgs.legacyPackages.${system} system);

    in
    {
      inherit nixosConfigurations;
    };

}
