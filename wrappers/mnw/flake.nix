{
  description = "My Neovim Setup; Best used for Nix as a Pkg Manager not part of NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      mnw,
    }:
    let
      x86_64 = "x86_64-linux";
      systems = [ x86_64 ];
      forAllSystems =
        apply:
        inputs.nixpkgs.lib.genAttrs systems (system: apply inputs.nixpkgs.legacyPackages.${system} system);
    in
    {
      defaultPackage = forAllSystems (
        pkgs: system:
        pkgs.callPackage ./default.nix {
          inherit pkgs;
          mnw = mnw;
        }
      );
    };
}
