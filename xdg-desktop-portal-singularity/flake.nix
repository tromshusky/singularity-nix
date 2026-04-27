{
  description = "xdg-desktop-portal-singularity packaged with libsingularity";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    libsingularity.url = "github:tromshusky/singularity-nix?dir=libsingularity";
    libsingularity.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      self,
      nixpkgs,
      libsingularity,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      libsing = libsingularity.packages.${system}.default;
    in
    {
      packages.${system}.default = pkgs.stdenv.mkDerivation {
        pname = "xdg-desktop-portal-singularity";
        version = "git";

        src = pkgs.fetchgit {
          url = "https://github.com/singularityos-lab/xdg-desktop-portal-singularity";
          sha256 = "sha256-bLHliNXdCFkoonSTxV4zkjsQzhMSRqMmuZ+XQ3Zb2LY=";
          # rev = "...";
        };

        nativeBuildInputs = with pkgs; [
          meson
          ninja
          pkg-config
          cmake
        ];

        buildInputs = with pkgs; [
          vala
          gtk4
          gtk4-layer-shell
          libgee
          json-glib
          pipewire
          libsing
        ];
      };
    };
}
