{ inputs }:
let
  inherit (inputs.nixpkgs) lib pkgs;
in
{
  user = {
    name = "Jmeow";
    email = "j@meow.rawr";
  };
}
