_: {
  options = {
    ignoreFile.default = ./meowEat;
    settings.mutators = [
      "/git"
    ];
  };

  mutations = {
    "/git".settings = { inputs }: import ./gitSettings.nix { inherit inputs; };
  };
}
