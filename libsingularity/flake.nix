{
  description = "Flake for libsingularity";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.stdenv.mkDerivation {
          pname = "libsingularity";
          version = "git";

          src = pkgs.fetchgit {
            url = "https://github.com/singularityos-lab/libsingularity";
            rev = "f859363a7a3840da0cbe6bb5231ab32dbc3be44d";
            sha256 = "sha256-gh7X9MhfxxZdbC6EhK+1rRMX7qCs8eZWySCGC4nzoAM=";
          };

          nativeBuildInputs = with pkgs; [
            meson
            ninja
            pkg-config
            cmake
            gobject-introspection
          ];

          buildInputs = with pkgs; [
            vala
            gtk4
            gtk4-layer-shell
            libgee
            json-glib
            libpeas2
          ];
        };
      }
    );
}
