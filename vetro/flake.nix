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
        packages.default = pkgs.buildGoModule {
          pname = "libsingularity";
          version = "git";

          src = vetro;
          vendorHash = "sha256-BKIYil3eWmwqIUf/46LY426uBN7qrVaqWX3YvODj8gc=";
        };
      }
    );
}
