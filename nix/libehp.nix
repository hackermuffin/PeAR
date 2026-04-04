{
  stdenv,
  fetchFromGitHub,
  # nixpkgs depencdencies
  cmake,
}:
stdenv.mkDerivation rec {
  name = "libehp-${version}";
  version = "5e41e26";
  src = fetchFromGitHub {
    owner = "GrammaTech";
    repo = "libehp";
    rev = "5e41e26b88d415f3c7d3eb47f9f0d781cc519459";
    sha256 = "sha256-PZaht6gDhrKX+uoFrJjYVzOuDx5qISseT1KQCotFvw0=";
  };
  nativeBuildInputs = [ cmake ];
  cmakeFlags = [ "-DEHP_BUILD_SHARED_LIBS=OFF" ];
}
