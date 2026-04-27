{
  description = "Flake for vetro";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.vetro.url = "github:singularityos-lab/vetro";
  inputs.vetro.flake = false;
  
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      vetro,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.vetro = pkgs.buildGoModule {
          pname = "libsingularity";
          version = "git";

          src = vetro;
        };
      }
    );
}
