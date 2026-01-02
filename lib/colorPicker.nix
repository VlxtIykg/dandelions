index:
let scheme = import ../assets/theme.nix;
in builtins.elemAt scheme.colors index
