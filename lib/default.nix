
lib:
lib // {
  destiny = {
    flattenToml = import ./flattenToml.nix lib;
    colorPicker = import ./colorPicker.nix;
    colorScheme = import ../assets/theme.nix;
  };
}
