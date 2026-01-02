{
  description = "Reincarnation";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    # nixpkgs.url = "nixpkgs/nixos-25.05";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    # zen-browser = { url = "github:0xc000022070/zen-browser-flake/beta"; };
    home-manager = {
      url = "github:nix-community/home-manager/master"; # unstable
      # url = "github:nix-community/home-manager/release-25.05"; # stable
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    niri.url = "github:sodiboo/niri-flake";
  };
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      niri,
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
