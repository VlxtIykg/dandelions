{ pkgs, mnw, ... }:
let
  args = { inherit pkgs; };
in
mnw.lib.wrap pkgs {
  appName = "nvim";
  aliases = [ "vim" ];
  neovim = pkgs.neovim.unwrapped.overrideAttrs {
    version = "0.12.0";
    src = pkgs.fetchFromGitHub {
      owner = "neovim";
      repo = "neovim";
      rev = "8499af1119f0f96b4fd57ef9099ce5a2503bc952";
      hash = "sha256-/PyUJOW1PMUdfy+ewWbngxttcaNsQmWpCEueNsAUBZE=";
    };
    doInstallCheck = false;
  };

  luaFiles = [
    ./init.lua
  ];

  plugins = {
    start = import ./packages/treesitter.nix args;
    startAttrs = import ./packages/startPlugins.nix args;
    dev.config = {
      pure = ./nvim;
      impure = "/data/dandelions/wrappers/mnw/nvim";
    };
  };
}
