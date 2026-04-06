# {
#   flattenToml = import ./flattenToml.nix;
#   colorPicker = import ./colorPicker.nix;
#   music-manager = import ./music-manager.nix;
# }

lib:
lib // {
  destiny = {
    flattenToml = import ./flattenToml.nix lib;
    colorPicker = import ./colorPicker.nix;
    music-manager = import ./music-manager.nix;

    colorScheme = import ../assets/theme.nix;
  };
}
