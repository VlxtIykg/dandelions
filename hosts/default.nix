{
  inputs,
  lib,
  nix-cachyos-kernel,
  helix-flake,
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
              (final: prev: {
                cloudflare-warp = prev.cloudflare-warp.overrideAttrs (old: rec {
                  version = "2025.10.186.0";
                  src = prev.fetchurl {
                    url = "https://pkg.cloudflareclient.com/pool/noble/main/c/cloudflare-warp/cloudflare-warp_${version}_amd64.deb";
                    hash = "sha256-l+csDSBXRAFb2075ciCAlE0bS5F48mAIK/Bv1r3Q8GE=";
                  };
                });
              })
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
