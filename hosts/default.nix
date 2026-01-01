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
        chaotic.nixosModules.default
        # chaotic.nixosModules.nyx-cache
        # chaotic.nixosModules.nyx-overlay
        # chaotic.nixosModules.nyx-registry
      ]
      ++ extra;
      specialArgs = {
        inherit inputs lib;
        # self = {
        #   wrappers = import ../lib/adios.nix {
        #     inherit pkgs;
        #     adios = inputs.adios.adios;
        #   }; # I could probably put
        #   # { inputs, lib, chaotic, pkgs, ... }: ...
        #   # then
        #   # inherit pkgs directly from there but we roll
        # };
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
