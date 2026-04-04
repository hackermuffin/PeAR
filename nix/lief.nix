{
  stdenv,
  fetchFromGitHub,
  # nixpkgs depencdencies
  cmake,
}:
stdenv.mkDerivation rec {
  name = "lief-${version}";
  version = "0.16.6";
  src = fetchFromGitHub {
    owner = "lief-project";
    repo = "LIEF";
    rev = version;
    sha256 = "sha256-SvwFyhIBuG0u5rE7+1OaO7VZu4/X4jVI6oFOm5+yCd8=";
  };
  nativeBuildInputs = [ cmake ];
  cmakeFlags = [
    "-DLIEF_PYTHON_API=OFF"
    "-DCMAKE_BUILD_TYPE=Release"
    "-DBUILD_SHARED_LIBS=OFF"
  ];
}
