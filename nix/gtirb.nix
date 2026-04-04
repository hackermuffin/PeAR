{
  stdenv,
  fetchFromGitHub,
  # nixpkgs depencdencies
  boost,
  cmake,
  protobuf,
  python3,
}:
stdenv.mkDerivation rec {
  name = "gtirb-${version}";
  version = "2.3.1";
  src = fetchFromGitHub {
    owner = "GrammaTech";
    repo = "gtirb";
    rev = "ceab3ba04d9e406a8c4406e5463a5bc7c645b7a6";
    sha256 = "sha256-XEQYSQxoVDvdzW2bBbbcB07BI5cTWGMaLoPWXcjLvi4=";
  };
  nativeBuildInputs = [
    boost
    cmake
    python3
  ];
  buildInputs = [ protobuf ];
  cmakeFlags = [
    # We're building with a more modern version of cmake than ubuntu20.04,
    # so need this for compatability
    "-DCMAKE_POLICY_VERSION_MINIMUM=3.5"
    # Build flags from Dockerfile
    "-DGTIRB_JAVA_API=OFF"
    "-DGTIRB_CL_API=OFF"
    "-DGTIRB_ENABLE_TESTS=OFF"
  ];
}
