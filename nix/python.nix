{
  # nixpkgs depencdencies
  python310,
  # manual dependeicies
  gtirb-pprinter,
  ddisasm,
}:
python310.withPackages (
  python-pkgs:
  with python-pkgs;
  let
    pear = buildPythonPackage {
      name = "pear";
      src = ./..;
      pyproject = true;
      build-system = [
        setuptools
      ];
      propagatedBuildInputs = [
        # manual dependencies
        gtirb-pprinter
        ddisasm
        # python dependencies
        cpp-demangle
        gtirb-rewriting
        pefile
        pytest
      ];
    };

    # PeAR depends on a whole network of python packages not in
    # nixpkgs, so we need to do the packaging ourselves...

    cpp-demangle = buildPythonPackage {
      pname = "cpp-demangle";
      version = "0.1.2";
      format = "wheel";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/4b/be/fbedac2a7ee9d372067ee4a9bacc232e4d6291317e37cd7dd2fabcd39a9c/cpp_demangle-0.1.2-cp310-cp310-manylinux_2_17_x86_64.manylinux2014_x86_64.whl";
        hash = "sha256-82EUa3FtzWjAIOlCqkjMqpPQgSpadw5kCIzaTkNWCw8=";
      };
    };
    gtirb-rewriting = buildPythonPackage {
      pname = "gtirb-rewriting";
      version = "0.4.1";
      format = "wheel";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/84/7e/39aa97e7ee1db21949048c54832d9f8c5b6b0a2f72506935b4a880435ecb/gtirb_rewriting-0.4.1-py3-none-any.whl";
        hash = "sha256-G1mDvHAb89yzUMSi5qTQTDwXyL4xUXglTxK8VxmbvG8=";
      };
      propagatedBuildInputs = [
        # manual deps
        gtirb
        gtirb-capstone
        gtirb-functions
        gtirb-layout
        mcasm

        # nixpkgs deps
        entrypoints
        leb128
        more-itertools
        typing-extensions
      ];
    };
    gtirb = buildPythonPackage {
      pname = "gtirb";
      version = "2.3.0";
      format = "wheel";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/9e/0d/5049a48da21f08f94d9c18c81611a128d04c36c37596e906dd785e0bddf3/gtirb-2.3.0-py3-none-any.whl";
        hash = "sha256-vxQ9tTvEvoIJ953LcUTMyx12f28Ii71xyrRRzh5m9/k=";
      };
      propagatedBuildInputs = [
        intervaltree
        networkx
        protobuf
        sortedcontainers
        typing-extensions
      ];
    };
    gtirb-capstone = buildPythonPackage {
      pname = "gtirb-capstone";
      version = "1.1.2";
      format = "wheel";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/25/97/cfd2339c1c3128b13ef6ff48323a614e53032df3f9580e19667cf98a914a/gtirb_capstone-1.1.2-py3-none-any.whl";
        hash = "sha256-IdiFM5SEzxI0wfZChKLxNvpUAynUWZDHeBZKjXaeVr8=";
      };
      propagatedBuildInputs = [
        capstone
        keystone-engine
      ];
    };
    gtirb-functions = buildPythonPackage {
      pname = "gtirb-functions";
      version = "1.0.9";
      format = "wheel";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/e2/db/c40e4c4b45aef743e9171fb6923b1c7e63ef3e9e4e3567010a04175530d3/gtirb_functions-1.0.9-py3-none-any.whl";
        hash = "sha256-cIBK4RxmkC2RQ0tOrGHqvoJ16jQZous0C8dhUV1imUA=";
      };
    };
    gtirb-layout = buildPythonPackage {
      pname = "gtirb-layout";
      version = "1.0.0";
      format = "wheel";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/36/13/97179e6d9d6e45054517d7a1773e53e4477260e292e73d1eb9ad37f7e910/gtirb_layout-1.0.0-py3-none-any.whl";
        hash = "sha256-G184wfKSz+Qn6iKJz4c1MrU9qnHT1coaSyf2D71eGGs=";
      };
    };
    mcasm = buildPythonPackage {
      pname = "mcasm";
      version = "0.3.0";
      format = "wheel";
      src = pkgs.fetchurl {
        url = "https://files.pythonhosted.org/packages/b7/6e/6b5b46508ec843c7179aa31a36211c1e13d5e79ae838f98dc0e55d5eaeea/mcasm-0.3.0-cp310-cp310-manylinux_2_12_x86_64.manylinux2010_x86_64.whl";
        hash = "sha256-uifH82xWqpPzeMBkLYj6oiEpivgD54Gf/vsY3zfXHR0=";
      };
    };
  in
  [
    pear
  ]
)
