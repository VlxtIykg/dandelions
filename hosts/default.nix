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
in
