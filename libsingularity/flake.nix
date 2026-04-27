{
  description = "Flake for libsingularity";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.libsingularity.url = "github:singularityos-lab/libsingularity";
  inputs.libsingularity.flake = false;
  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      libsingularity,
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

          src = libsingularity;

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

          installPhase = ''
            mkdir -p $out/lib/pkgconfig
            ln -s libsingularity-1.0.pc $out/lib/pkgconfig/singularity-1.0.pc
          '';
        };
      }
    );
}
