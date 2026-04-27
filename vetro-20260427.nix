{
  pkgs ? import <nixpkgs> { },
}:

pkgs.buildGoModule {
  pname = "vetro";
  version = "git";

  src = builtins.fetchGit {
    url = "https://github.com/singularityos-lab/vetro";
    rev = "751ccb251d9fb2c472e193bc478c3b928e3514c9";
  };
  vendorHash = "sha256-BKIYil3eWmwqIUf/46LY426uBN7qrVaqWX3YvODj8gc=";
}
