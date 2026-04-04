{
  stdenv,
  fetchFromGitHub,
  # nixpkgs depencdencies
  abseil-cpp,
  boost,
  capstone,
  cmake,
  mcpp,
  pandoc,
  protobuf,
  python3,
  souffle,
  # Manually supplied dependencies
  gtirb,
  gtirb-pprinter,
  libehp,
  lief,
}:
stdenv.mkDerivation rec {
  name = "ddisasm-${version}";
  version = "1.9.3";
  src = fetchFromGitHub {
    owner = "GrammaTech";
    repo = "ddisasm";
    rev = "b9b362d368c50fb3cfb3cd817634a1c2f9bfd2d8";
    sha256 = "sha256-IeoOti5FKz7LVQrU8joNHpwg2U3diXQsLFSaScohOlM=";
  };
  nativeBuildInputs = [
    abseil-cpp
    boost
    capstone
    cmake
    mcpp
    pandoc
    protobuf
    python3
    souffle
    gtirb
    gtirb-pprinter
    libehp
    lief
  ];
  cmakeFlags = [
    # We're building with a more modern version of cmake than ubuntu20.04,
    # so need this for compatability
    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    # Build flags from Dockerfile
    "-DDDISASM_ENABLE_TESTS=OFF"
    "-DDDISASM_GENERATE_MANY=ON"
  ];
}
