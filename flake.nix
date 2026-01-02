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

    adios.url = "github:adisbladis/adios";
    niri.url = "github:sodiboo/niri-flake";
  };

  # outputs = inputs@{ nixpkgs, home-manager, niri, chaotic, ... }:
  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      self,
      niri,
      chaotic,
      ...
    }:
    let
      # system = inputs.nixpkgs.legacyPackages."x86_64-linux";
      system = "x86_64-linux";
      pkgs = inputs.nixpkgs.legacyPackages.${system};
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
      defaultWrappers = forAllSystems (
        pkgs: _:
        import ./lib/adios.nix {
          inherit pkgs inputs;
          adios = inputs.adios.adios;
        }
      );

      packages = forAllSystems (
        pkgs: system:
        let
          wrappers = inputs.self.defaultWrappers.${system};
        in
        {
          git = wrappers.git { };

          # This path is looking /dandelions/gitconf.nix not /dandelions/wrappers/git/gitconfig.nix
          gitPC = wrappers.git {
            ignoreFile = ./hosts/radio/config/.gitignore;
            # options = { inherit wrappers; }.git.options;
            # iniConfig = import ./hosts/radio/config/gitUserSettings.nix { inherit options; };
            name = "kami";
            email = "97310758+VlxtIykg@users.noreply.github.com";
            gitSettingPath = ./hosts/radio/config/gitUserSettings.nix;
          };

          gitLappy = wrappers.git {
            ignoreFile = ./ignore;
            iniConfig = import ./hosts/common/core/gitUserSettings.nix { inherit inputs; };
            # iniConfig = import ./wrappers/git/gitSettings.nix { inherit inputs; };
            # ignoreFile = ./gitignore;
          };
        }
      );

      devShells = forAllSystems (
        pkgs: system: {
          default = import ./hosts/common/core/shell.nix { inherit inputs system pkgs; };
          radio = import ./hosts/radio/core/shell.nix { inherit inputs system pkgs; };
          # otherUser = ; # for future user, on lap1, pi1, lap2, friendlap1, friendGc2lap1, friendGc2lap2
          friendTest = import ./modules/friendShell.nix;
        }
      );

    };

}
