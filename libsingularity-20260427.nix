{
  pkgs ? import <nixpkgs> { },
}:

pkgs.stdenv.mkDerivation {
  pname = "libsingularity";
  version = "git";

  src = builtins.fetchGit {
    url = "https://github.com/singularityos-lab/libsingularity";
    rev = "f859363a7a3840da0cbe6bb5231ab32dbc3be44d";
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
}
