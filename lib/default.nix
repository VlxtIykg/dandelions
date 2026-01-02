
lib:
lib // {
  destiny = {
    flattenToml = import ./flattenToml.nix lib;
    colorScheme = import ../assets/theme.nix;
  };
}
