{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  inherit (lib.options) mkEnableOption;
  inherit (lib.modules) mkIf mkDefault;
  inherit (config.destiny.flake.system) user;

  cfg = config.destiny.home-manager;
  stateVersion = mkDefault "25.05";
in
{

  options.destiny.home-manager = {
    enable = mkEnableOption "home-manager";
  };

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  config = mkIf cfg.enable {
    services.gnome.gcr-ssh-agent.enable = true;
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;

      users.${user} = {
        programs = {
          home-manager.enable = true;
        };

        gtk.enable = true;
        home = {
          username = user;
          homeDirectory = "/home/${user}";
          # file.backupNixos.text = ''

          # '';
          # file.backupNixos.executable = true;
          # put simple curl script in backupNixos then run bash script to curl the script
          file.updateNixos.text = ''
            #!/usr/bin/env bash
            export gitConfigPath=/data/dandelions
            export TMP_NIXCONFIG_FOLDER=/tmp/tmpnixconfigDir
            sudo mkdir -p --mode=777 $TMP_NIXCONFIG_FOLDER
            sudo rsync -rptgDovh --delete --progress --exclude-from=$gitConfigPath/.gitignore --partial $gitConfigPath $TMP_NIXCONFIG_FOLDER
            sudo rm -rfv $TMP_NIXCONFIG_FOLDER/.git
            nixos-rebuild test --show-trace --sudo --flake $TMP_NIXCONFIG_FOLDER#radio;

            if [ $? == 0 ]; then
            	clear && nix run nixpkgs#nyancat -- -f 2;
            	echo -en "\x1b[33mSystem has swapped to the new configuration!\n\x1b[0m"
            else
            	echo -en "\n---\nCOULD NOT \x1b[31mREMOVE\x1b[0m TMP FOLDER??!?!?!??!?!?!??!??!?!?\n\n"
            fi
          '';
          file.updateNixos.executable = true;
          file.".config/direnv/direnv.toml".text = ''
            [global]
            log_filter="^$"
          '';
          file.".profile".text = ''
            export PATH="$PATH:/home/kami/.bun/bin"
          '';
          inherit stateVersion;
        };
      };

    };
  };
}
