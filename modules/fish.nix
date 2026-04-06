{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.destiny.programs.fish;
  path = "/data/dandelions/";

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
        # set -x PATH "$HOME/.npm_packages/bin/" $PATH
        shellInit = "export DIRENV_LOG_FORMAT=;direnv hook fish | source";
        interactiveShellInit = builtins.concatStringsSep "\n" [
          ''
            function fish_greeting
              uname -nrv
              echo
              echo "As the river of time flows, so will fate untwine. At the last moment, all will crumble as the two fight for control."
              date
            end

            set -g fish_greeting
            set -x DISPLAY ":0.0"
            fish_add_path --append --path /home/kami/.bun/bin
            fish_add_path --append --path /data
          ''
          (builtins.readFile ../assets/prompt.fish)
        ];

        binds = {
          "ctrl-z".command = "fg 2>/dev/null; commandline -f repaint";
        };

        shellAbbrs = {
          projs = "cd /data/db4/Github";
        };

        shellAliases = {
          cargo = "cargo mommy";
          ctest = "cargo test";
          cmtest = "cargo miri test";
          cchck = "cargo check";
          g = "git";
          v = "vim";
          ":q" = "exit";
          gcmt = "git commit -m";
          gpsh = "git push";
          nxsh = "nix-shell -p";
          nxshellify = "nix-shellify -p";
          proj = "vim /data/db4/Github/";
          nixcfg = "vim ${path}";
          # nxr = "sudo nixos-rebuild switch --flake ${path}#radio"; # Git add required to proceed to boot
          nxr = "bash ${path}lib/upgradeNixos"; # Doesn't require git like the above line. Reason being the script just copies over
          nxrtest = "bash ${path}lib/updateNixos"; # Will update the system on hand. Use this till sure won't break
          snooze = "${pkgs.systemd}/bin/poweroff";
          phoenix = "${pkgs.systemd}/bin/reboot";
          screensaver = "nix run nixpkgs#nyancat";
          clear = "nix run nixpkgs#nyancat -- -f 20";
          catto = "nix run nixpkgs#nyancat";
          what2do2day = "vim /data/db4/Github/todo_list.txt";
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
