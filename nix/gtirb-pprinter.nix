{
  stdenv,
  fetchFromGitHub,
  # nixpkgs depencdencies
  abseil-cpp,
  boost,
  capstone,
  cmake,
  gtest,
  # Manually supplied dependencies
  gtirb,
  protobuf,
}:
stdenv.mkDerivation rec {
  name = "gtrib-pprinter-${version}";
  version = "2.2.3";
  src = fetchFromGitHub {
    owner = "GrammaTech";
    repo = "gtirb-pprinter";
    rev = "bba87a3d2bcb62cfbcc2b8144da1745512002875";
    sha256 = "sha256-JSirTuq8Qu10qL8Xv4lZmPRKuu/lbnWkLAYaudnKWDI=";
  };
  nativeBuildInputs = [
    abseil-cpp
    boost
    capstone
    cmake
    gtest
    gtirb
  ];
  buildInputs = [ protobuf ];
  cmakeFlags = [
    # We're building with a more modern version of cmake than ubuntu20.04,
    # so need this for compatability
    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    # Disable needing gtest framework to build under nix
    "-DGTIRB_PPRINTER_ENABLE_TESTS=OFF"
  ];
}
