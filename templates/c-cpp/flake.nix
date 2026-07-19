{
  description = "Projeto C/C++";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            gcc
            gnumake
            cmake
            pkg-config
            gdb
            clang-tools   # clangd, clang-format
            # Bibliotecas comuns em codigo de engenharia/numerico:
            # openmpi       # paralelismo (relevante p/ CFD)
            # fftw
            # openblas
          ];

          shellHook = ''
            echo "$(gcc --version | head -n1)"
          '';
        };
      });
}
