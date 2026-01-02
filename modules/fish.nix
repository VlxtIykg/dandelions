{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.destiny.programs.fish;
  path = "/etc/nixos/dandelions/";

  inherit (config.destiny.flake.system) user;
  inherit (lib.options) mkEnableOption;
in
{
  options.destiny.programs.fish = {
    enable = mkEnableOption "fish";
  };

  config = lib.modules.mkIf cfg.enable {
    home-manager.users.${user} = {
      programs.fish = {
        enable = true;
        shellInit = "direnv hook fish | source";
        interactiveShellInit = builtins.concatStringsSep "\n" [
          ''
            function fish_greeting
              uname -nrv
              echo
              echo "As the river of time flows, so will fate untwine. At the last moment, all will crumble as the two fight for control."
              date
            end

            set -g fish_greeting
            set -x PATH "$HOME/.npm_packages/bin/" $PATH
            set -x DISPLAY ":0.0"
          ''
          (builtins.readFile ../assets/prompt.fish)
        ];

        shellAbbrs = {
          projs = "cd /data/db4/Github";
        };

        shellAliases = {
          cargo = "cargo mommy";
          ctest = "cargo test";
          cmtest = "cargo miri test";
          cchck = "cargo check";
          g = "git";
          v = "hx";
          ":q" = "exit";
          gcmt = "git commit -m";
          gpsh = "git push";
          nxsh = "nix-shell -p";
          proj = "hx /data/db4/Github/";
          nixcfg = "hx ${path}";
          nxr = "sudo nixos-rebuild switch --flake ${path}#radio"; # Git add required to proceed to boot
          nxrtest = ''
            bash ${path}lib/updateNixos || bash ~/updateNixos
          ''; # Will update the system on hand. Use this till sure won't break
          snooze = "poweroff";
          phoenix = "sudo reboot now";
          screensaver = "nix run nixpkgs#nyancat";
          clear = "nix run nixpkgs#nyancat -- -f 20";
          catto = "nix run nixpkgs#nyancat";
          what2do2day = "hx /data/db4/Github/todo_list.txt";
        };

        plugins = [
          {
            name = "grc";
            src = pkgs.fishPlugins.grc.src;
          }

          {
            name = "hydro";
            src = pkgs.fishPlugins.hydro.src;
          }

          {
            name = "fzf";
            src = pkgs.fishPlugins.fzf.src;
          }

          {
            name = "z";
            src = pkgs.fetchFromGitHub {
              owner = "jethrokuan";
              repo = "z";
              rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
              sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
            };
          }
        ];
      };
    };
  };
}
