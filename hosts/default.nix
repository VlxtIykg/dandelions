{
  inputs,
  pkgs,
  lib,
  chaotic,
  ...
}:
let
  inherit (lib) nixosSystem map listToAttrs;
  sysConfigDir = dir: import (lib.path.append dir "system.nix") { inherit inputs; };

  mkSystem =
    extra: directory:
    nixosSystem {
      system = null;
      modules = [
        ./common/core
        ../modules
        directory
        (
          { pkgs, ... }:
          {
            nixpkgs.overlays = [
              nix-cachyos-kernel.overlays.pinned
            ];

          }
        )
      ]
      ++ extra;
      specialArgs = {
        inherit inputs lib helix-flake;
      };
    };

  allHosts =
    hosts:
    listToAttrs (
      map (host: {
        name = (sysConfigDir host.directory).destiny.flake.system.host;
        value = mkSystem [ ] host.directory;
      }) hosts
    );

in
allHosts [ { directory = ./radio; } ]
