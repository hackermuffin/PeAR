{
  description = "PeAR - the Performant AFL Rewriter. Instrument Linux and Windows binaries with fuzzing instrumentation and more.";

  inputs = {
    nixpkgs.url = "github:nixOS/nixpkgs/nixos-25.11";
  };

  outputs =
    { nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      # build required packages, building of current latest versions
      # the full build process is fairly heavy, and will take some time for
      # first build
      boost = pkgs.boost177;
      libehp = pkgs.callPackage ./nix/libehp.nix { };
      lief = pkgs.callPackage ./nix/lief.nix { };
      gtirb = pkgs.callPackage ./nix/gtirb.nix { inherit boost; };
      # output packages
      gtirb-pprinter = pkgs.callPackage ./nix/gtirb-pprinter.nix { inherit boost gtirb; };
      ddisasm = pkgs.callPackage ./nix/ddisasm.nix {
        inherit
          boost
          gtirb
          gtirb-pprinter
          libehp
          lief
          ;
      };
      # build python enviroment, with binary and python dependencies
      python = pkgs.callPackage ./nix/python.nix { inherit gtirb-pprinter ddisasm; };
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          # Core depedencies
          ddisasm
          gtirb-pprinter
          python
          aflplusplus
        ];
      };

      apps.${system} = rec {
        default = pear;
        ddisasm = {
          type = "app";
          program = "${ddisasm}/bin/ddisasm";
        };
        gtirb-pprinter = {
          type = "app";
          program = "${gtirb-pprinter}/bin/gtirb-pprinter";
        };
        pear = {
          type = "app";
          program = "${python}/bin/pear";
        };
        PeAR = pear;
      };

    };

}
