{
  description = "Reincarnation";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    stable-nixpkgs.url = "github:NixOS/nixpkgs/1c1c9b3f5ec0421eaa0f22746295466ee6a8d48f";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    # chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable"; # :( it is now deprecated
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

    adios.url = "github:llakala/adios";
    adios-wrappers.url = "github:llakala/adios-wrappers";
    adios-wrappers.inputs.adios.follows = "adios";
    niri.url = "github:sodiboo/niri-flake";
    raycast-lin.url = "github:vicinaehq/vicinae";
    raycast-lin-ext.url = "github:vicinaehq/extensions";
    # raycast-lin-ext.inputs.nixpkgs.follows = "nixpkgs";
    helix-flake.url = "github:helix-editor/helix";
    mnw.url = "github:Gerg-L/mnw";
  };

  outputs =
    inputs@{
      nixpkgs,
      stable-nixpkgs,
      home-manager,
      self,
      niri,
      nix-cachyos-kernel,
      raycast-lin,
      helix-flake,
      mnw,
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
          nix-cachyos-kernel
          helix-flake
          pkgs
          ;
      };

      systems = [ "x86_64-linux" ];
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
          # adios-wrappers = inputs.adios-wrappers.yggdrasil;
          adios-wrappers = inputs.adios-wrappers.wrapperModules;
        }
      );

      packages = forAllSystems (
        pkgs: system:
        let
          wrappers = inputs.self.defaultWrappers.${system};
        in
        {
          git = wrappers.git.drv;
          gitPC = wrappers.git.drv;
          bat = wrappers.bat.drv;
          mnw = import ./wrappers/mnw/default.nix { inherit pkgs mnw; };

          # This path is looking /dandelions/gitconf.nix not /dandelions/wrappers/git/gitconfig.nix
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
          allowSubstitutes = false;
          default = import ./hosts/common/core/shell.nix { inherit inputs system pkgs; };
          radio = import ./hosts/radio/core/shell.nix { inherit inputs system pkgs; };
          # otherUser = ; # for future user, on lap1, pi1, lap2, friendlap1, friendGc2lap1, friendGc2lap2
          friendTest = import ./modules/friendShell.nix;
        }
      );

    };

}
